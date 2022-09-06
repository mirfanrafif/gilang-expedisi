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

    on<CompleteJobEvent>(onCompleteJob);
    on<ResetSoEvent>(onReset);
    on<UpdateTimbangEvent>(onUpdateTimbang);
    on<SelectSOEvent>(onSelectSo);
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

      emit(SoSelected(timbang: newTimbang));
    }
  }

  Future<void> onSelectSo(SelectSOEvent event, Emitter<SoState> emit) async {
    soRepository.setSession(event.timbang.id);
    emit(SoSelected(timbang: event.timbang));
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
    emit(SoSelected(timbang: event.newTimbang));
  }
}
