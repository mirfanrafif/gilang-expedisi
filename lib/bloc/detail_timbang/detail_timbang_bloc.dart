import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/produk.dart';
import '../../data/models/timbang.dart';
import '../../data/models/timbang_detail.dart';
import '../../data/repository/so_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../utils/data_mapper.dart';

part 'detail_timbang_event.dart';
part 'detail_timbang_state.dart';

class DetailTimbangBloc extends Bloc<DetailTimbangEvent, DetailTimbangState> {
  var soRepository = SoRepository();
  var userRepository = UserRepository();

  DetailTimbangBloc() : super(DetailTimbangInitial()) {
    on<ProcessJobEvent>(onJobProcess);
    on<TambahDetailTimbangEvent>(onTambahTimbang);
    on<SetTimbangProdukEvent>(onSetProduk);
    on<TimbangUlangSebelumnya>(onTimbangUlang);
    on<KirimBuktiVerifikasiEvent>(onKirimBuktiVerifikasi);
  }

  Future<void> onTambahTimbang(
      TambahDetailTimbangEvent event, Emitter<DetailTimbangState> emit) async {
    var timbangDetail = event.detail;
    await timbangDetail.save();
    emit(SelectedProductState(
      event.timbang,
      event.produk,
      [...state.listDetail, timbangDetail],
    ));
  }

  void onSetProduk(
      SetTimbangProdukEvent event, Emitter<DetailTimbangState> emit) async {
    emit(SelectedProductState(
        event.timbang, event.produk, event.produk.listTimbangDetail));
  }

  Future<void> onTimbangUlang(
      TimbangUlangSebelumnya event, Emitter<DetailTimbangState> emit) async {
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

  Future<void> onKirimBuktiVerifikasi(
      KirimBuktiVerifikasiEvent event, Emitter<DetailTimbangState> emit) async {
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
  }

  Future<void> onJobProcess(
      ProcessJobEvent event, Emitter<DetailTimbangState> emit) async {
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

    emit(ProcessJobSuccessState(newTimbang));
  }
}
