import 'dart:async';
import 'dart:io';

import 'package:aplikasi_timbang/data/models/produk.dart';
import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:aplikasi_timbang/data/repository/so_repository.dart';
import 'package:aplikasi_timbang/data/repository/user_repository.dart';
import 'package:aplikasi_timbang/utils/data_mapper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/timbang_detail.dart';
import '../../data/responses/upload_bukti_response.dart';
import '../../data/services/response.dart';

part 'so_event.dart';
part 'so_state.dart';

class SoBloc extends Bloc<SoEvent, SoState> {
  var soRepository = SoRepository();
  var userRepository = UserRepository();

  SoBloc() : super(SoInitial()) {
    on<GetSessionEvent>(onGetSession);
    on<CariSoEvent>(onCariSo);
    on<ProcessJobEvent>(onJobProcess);
    on<TambahDetailTimbangEvent>(onTambahTimbang);
    on<SetTimbangProdukEvent>(onSetProduk);
    on<TimbangUlangSebelumnya>(onTimbangUlang);
    on<KirimBuktiVerifikasiEvent>(onKirimBuktiVerifikasi);
    on<CompleteJobEvent>(onCompleteJob);
    on<ResetSoEvent>(onReset);
  }

  Future<void> onGetSession(
      GetSessionEvent event, Emitter<SoState> emit) async {
    var session = soRepository.getSession();
    if (session != null) {
      //hasil dari cari SO
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
    emit(SoLoading(state.listDetail));
    var token = userRepository.getToken();
    var user = userRepository.getUser();
    var response = await soRepository.cariSo(event.id, token ?? '');

    if (!response.success) {
      emit(SoNotFound(
        id: event.id,
        message: response.message,
        listDetail: state.listDetail,
      ));
      return;
    }
    var data = response.data!.data;

    if (data.isEmpty) {
      emit(SoNotFound(
        id: event.id,
        message: 'Tidak ada SO dengan nomor ' + event.id.toString(),
        listDetail: state.listDetail,
      ));
      return;
    }

    var firstSoResult = data.first;

    //hasil dari cari SO
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

    //karena di setiap SO ada produk yang ditimbang, contoh ayam hidup, maka buatkan classnya juga
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

  Future<void> onJobProcess(
      ProcessJobEvent event, Emitter<SoState> emit) async {
    var requestItems =
        makeJobProcessRequestItems(event.produk, event.listDetail);
    var request = makeJobProcessRequest(
        requestItems, event.produk.buktiVerifikasiUrl ?? '');

    var token = userRepository.getToken();

    var response =
        await soRepository.processJob(request, event.timbang.id, token ?? '');

    if (response.success) {
      event.produk.syncWithApi = true;
      await event.produk.save();
    }

    var newTimbang = event.timbang;
    var newListProduk = [...newTimbang.listProduk];
    var produkIndex = newTimbang.listProduk
        .indexWhere((element) => element.id == event.produk.id);
    newListProduk[produkIndex] = event.produk;

    newTimbang.listProduk = newListProduk;

    emit(SoLoaded(newTimbang));
  }

  void onSetProduk(SetTimbangProdukEvent event, Emitter<SoState> emit) async {
    emit(SelectedProductState(
        event.timbang, event.produk, event.produk.listTimbangDetail));
  }

  FutureOr<void> onTambahTimbang(
      TambahDetailTimbangEvent event, Emitter<SoState> emit) async {
    var timbangDetail = event.detail;
    await timbangDetail.save();
    emit(SelectedProductState(
      event.timbang,
      event.produk,
      [...state.listDetail, timbangDetail],
    ));
  }

  Future<void> onTimbangUlang(
      TimbangUlangSebelumnya event, Emitter<SoState> emit) async {
    var previousDetail = await TimbangDetail.getPreviousDetail(event.produk.id);

    if (previousDetail != null) {
      var newListDetail = [...state.listDetail];
      newListDetail.removeLast();
      emit(PreviousTimbangDetailState(
        event.timbang,
        event.produk,
        newListDetail,
        previousDetail,
      ));
    } else {
      emit(SelectedProductState(
        event.timbang,
        event.produk,
        state.listDetail,
      ));
    }
  }

  Future<ApiResponse<UploadBuktiResponse?>> onKirimBuktiVerifikasi(
      KirimBuktiVerifikasiEvent event, Emitter<SoState> emit) async {
    //file bukti dipindah direktorinya agar tidak mudah terhapus
    var docPath = await getApplicationDocumentsDirectory();
    var newFile = File(docPath.path + event.bukti.path.split('/').last);
    newFile.writeAsBytes(event.bukti.readAsBytesSync());

    //simpan path bukti verifikasi yang sudah dipindah
    var newProduk = event.produk;
    newProduk.buktiVerifikasi = newFile.path;
    newProduk.selesaiTimbang = true;
    await newProduk.save();

    //upload bukti
    var token = userRepository.getToken();
    var response = await soRepository.uploadBukti(newFile, token ?? '');

    //jika sukses, maka simpan url nya di database
    if (response.success) {
      newProduk.buktiVerifikasiUrl = response.data?.url ?? '';
      await newProduk.save();

      emit(TimbangProdukSelesaiState(
        event.timbang,
        newProduk,
        state.listDetail,
      ));
    } else {
      emit(UploadBuktiErrorState(
        event.timbang,
        newProduk,
        response.message,
        state.listDetail,
      ));
    }

    return response;
  }

  Future<void> onCompleteJob(
      CompleteJobEvent event, Emitter<SoState> emit) async {
    //upload bukti
    var token = userRepository.getToken();
    var response =
        await soRepository.completeJob(event.timbang.id, token ?? '');

    if (response.success) {
      soRepository.removeSession();
      emit(SoComplete());
    }
  }

  Future<void> onReset(ResetSoEvent event, Emitter<SoState> emit) async {
    emit(SoInitial());
  }
}
