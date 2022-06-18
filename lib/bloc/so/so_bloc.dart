import 'dart:async';

import 'package:aplikasi_timbang/data/models/produk.dart';
import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:aplikasi_timbang/data/repository/so_repository.dart';
import 'package:aplikasi_timbang/data/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/timbang_detail.dart';

part 'so_event.dart';
part 'so_state.dart';

class SoBloc extends Bloc<SoEvent, SoState> {
  var soRepository = SoRepository();
  var userRepository = UserRepository();

  SoBloc() : super(const SoInitial()) {
    on<GetSessionEvent>(onGetSession);
    on<CariSoEvent>(onCariSo);
    on<CompleteJobEvent>(onCompleteJob);
    on<ResetSoEvent>(onReset);
    on<UpdateTimbangEvent>(onUpdateTimbang);
  }

  Future<void> onGetSession(
      GetSessionEvent event, Emitter<SoState> emit) async {
    var session = soRepository.getSession();
    if (session != null) {
      //hasil dari cari PO
      var newTimbang = await Timbang.findById(session);
      var listProduk = await TimbangProduk.getByTimbangId(newTimbang!.id);

      for (var produk in listProduk) {
        var timbangDetail = await TimbangDetail.getByProdukId(produk.id);
        produk.listTimbangDetail = timbangDetail;
      }

      newTimbang.listProduk = listProduk;

      emit(SoLoaded(newTimbang));
    }
  }

  void onCariSo(CariSoEvent event, Emitter<SoState> emit) async {
    emit(const SoLoading());
    var token = userRepository.getToken();
    var user = userRepository.getUser();
    var response = await soRepository.cariSo(event.id, token ?? '');

    if (!response.success && response.responseCode == 401) {
      var currentUser = userRepository.getUser();
      var newToken =
          await userRepository.login(currentUser.email, currentUser.password);

      userRepository.saveToken(newToken.data?.accessToken ?? '');

      token = userRepository.getToken();
      response = await soRepository.cariSo(event.id, token ?? '');
    }

    if (!response.success) {
      emit(SoNotFound(
        id: event.id,
        message: response.message,
      ));
      return;
    }
    var data = response.data!.data;

    if (data.isEmpty) {
      emit(SoNotFound(
        id: event.id,
        message: 'Tidak ada PO dengan nomor ' + event.id.toString(),
      ));
      return;
    }

    var firstSoResult = data.first;

    //hasil dari cari PO
    var newTimbang = await Timbang.findById(firstSoResult.id ?? 0);

    //mencari data di sqlite, jika sudah ada ambil disana aja
    if (newTimbang == null) {
      newTimbang = Timbang(
        firstSoResult.id ?? 0,
        firstSoResult.number ?? 0,
        user.id,
        firstSoResult.customer?.fullName ?? '',
        firstSoResult.shippingAddress ?? '',
      );
      await newTimbang.save();
    }

    //karena di setiap PO ada produk yang ditimbang, contoh ayam hidup, maka buatkan classnya juga
    for (var produk in firstSoResult.products) {
      var newProduk = await TimbangProduk.findById(produk.id ?? 0);
      if (newProduk == null) {
        newProduk = TimbangProduk(
            produk.id ?? 0,
            produk.product?.name ?? '',
            produk.amount?.toInt() ?? 0,
            produk.amount?.toInt() ?? 0,
            produk.description,
            newTimbang.id);
        await newProduk.save();
      }
      var timbangDetail = await TimbangDetail.getByProdukId(newProduk.id);
      newProduk.listTimbangDetail = timbangDetail;
      newTimbang.tambahProduk(newProduk);
    }

    //atur sesi timbang
    soRepository.setSession(newTimbang.id);

    emit(SoLoaded(newTimbang));
  }

  Future<void> onCompleteJob(
      CompleteJobEvent event, Emitter<SoState> emit) async {
    //upload bukti
    var token = userRepository.getToken();
    var response =
        await soRepository.completeJob(event.timbang.id, token ?? '');

    if (!response.success && response.responseCode == 401) {
      var currentUser = userRepository.getUser();
      var newToken =
          await userRepository.login(currentUser.email, currentUser.password);

      userRepository.saveToken(newToken.data?.accessToken ?? '');

      token = userRepository.getToken();
      response = await soRepository.completeJob(event.timbang.id, token ?? '');
    }

    if (response.success) {
      soRepository.removeSession();
      emit(const SoComplete());
    }
  }

  Future<void> onReset(ResetSoEvent event, Emitter<SoState> emit) async {
    emit(const SoInitial());
  }

  Future<void> onUpdateTimbang(
      UpdateTimbangEvent event, Emitter<SoState> emit) async {
    emit(SoLoaded(event.newTimbang));
  }
}
