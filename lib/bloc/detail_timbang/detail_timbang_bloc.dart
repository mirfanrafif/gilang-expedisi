import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
    on<UpdateTimbangDetailEvent>(onUpdateTimbangDetail);
    on<DeleteTimbangDetailEvent>(onDeleteTimbangDetail);
  }

  Future<void> onTambahTimbang(
      TambahDetailTimbangEvent event, Emitter<DetailTimbangState> emit) async {
    var timbangDetail = event.detail;
    await timbangDetail.save();
    emit(SelectedProductState(
      event.produk,
      [...state.listDetail, timbangDetail],
    ));
  }

  void onSetProduk(
      SetTimbangProdukEvent event, Emitter<DetailTimbangState> emit) async {
    emit(SelectedProductState(event.produk, event.produk.listTimbangDetail));
  }

  Future<void> onTimbangUlang(
      TimbangUlangSebelumnya event, Emitter<DetailTimbangState> emit) async {
    var previousDetail = await TimbangDetail.getPreviousDetail(event.produk.id);

    if (previousDetail != null) {
      var newListDetail = [...state.listDetail];
      newListDetail.removeLast();
      emit(PreviousTimbangDetailState(
        event.produk,
        newListDetail,
        previousDetail,
      ));
    } else {
      emit(SelectedProductState(
        event.produk,
        state.listDetail,
      ));
    }
  }

  Future<void> onKirimBuktiVerifikasi(
      KirimBuktiVerifikasiEvent event, Emitter<DetailTimbangState> emit) async {
    //file bukti dipindah direktorinya agar tidak mudah terhapus
    var docPath = await getApplicationDocumentsDirectory();
    print("Besar file lama: " + (await event.bukti.length()).toString());

    var namaFile = 'buktitimbang-' +
        event.produk.id.toString() +
        '-' +
        ((DateTime.now().millisecondsSinceEpoch / 1000).round()).toString() +
        '.' +
        event.bukti.path.split('.').last;

    var newFile = await FlutterImageCompress.compressAndGetFile(
      event.bukti.path,
      docPath.path + '/' + namaFile,
      quality: 80,
    );

    if (newFile == null) {
      return;
    }

    print(newFile.path);
    print("Besar file baru: " + ((await newFile.length()).toString()));

    //simpan path bukti verifikasi yang sudah dipindah
    var newProduk = event.produk;
    newProduk.buktiVerifikasi = newFile.path;

    await newProduk.save();

    emit(UploadingBuktiTimbangState(event.produk, state.listDetail));

    //upload bukti
    var token = userRepository.getToken();
    var response = await soRepository.uploadBukti(newFile, token ?? '');

    if (!response.success && response.responseCode == 401) {
      var currentUser = userRepository.getUser();
      var newToken =
          await userRepository.login(currentUser.email, currentUser.password);

      userRepository.saveToken(newToken.data?.accessToken ?? '');

      token = userRepository.getToken();
      response = await soRepository.uploadBukti(newFile, token ?? '');
    }

    //jika sukses, maka simpan url nya di database
    if (response.success) {
      newProduk.buktiVerifikasiUrl = response.data?.url ?? '';
      await newProduk.save();

      emit(TimbangProdukSelesaiState(
        newProduk,
        state.listDetail,
      ));
    } else {
      emit(UploadBuktiErrorState(
        newProduk,
        response.message,
        state.listDetail,
      ));
    }
  }

  Future<void> onJobProcess(
      ProcessJobEvent event, Emitter<DetailTimbangState> emit) async {
    emit(ProcessingJobState(event.listDetail));
    var requestItems =
        makeJobProcessRequestItems(event.produk, event.listDetail);
    var request = makeJobProcessRequest(
        requestItems, event.produk.buktiVerifikasiUrl ?? '');

    var token = userRepository.getToken();

    var response =
        await soRepository.processJob(request, event.timbang.id, token ?? '');

    if (!response.success && response.responseCode == 401) {
      var currentUser = userRepository.getUser();
      var newToken =
          await userRepository.login(currentUser.email, currentUser.password);

      userRepository.saveToken(newToken.data?.accessToken ?? '');

      token = userRepository.getToken();
      response =
          await soRepository.processJob(request, event.timbang.id, token ?? '');
    }

    if (response.success) {
      event.produk.syncWithApi = true;
      event.produk.selesaiTimbang = true;
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

  Future<void> onUpdateTimbangDetail(
      UpdateTimbangDetailEvent event, Emitter<DetailTimbangState> emit) async {
    var index =
        state.listDetail.indexWhere((element) => element.id == event.detail.id);

    if (index > -1) {
      var newListDetail = [...state.listDetail];
      var selectedDetail = newListDetail[index];
      newListDetail.removeAt(index);
      emit(UpdateTimbangDetailState(
          event.produk, newListDetail, selectedDetail, index));
    }
  }

  Future<void> onDeleteTimbangDetail(
      DeleteTimbangDetailEvent event, Emitter<DetailTimbangState> emit) async {
    var index =
        state.listDetail.indexWhere((element) => element.id == event.detail.id);

    if (index > -1) {
      var newListDetail = [...state.listDetail];
      var selectedDetail = newListDetail[index];
      await selectedDetail.delete();
      newListDetail.removeAt(index);

      emit(DeleteTimbangDetailState(event.produk, newListDetail));
      emit(SelectedProductState(event.produk, newListDetail));
    }
  }
}
