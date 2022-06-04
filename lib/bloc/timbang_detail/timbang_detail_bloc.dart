import 'dart:async';

import 'package:aplikasi_timbang/data/models/produk.dart';
import 'package:aplikasi_timbang/data/models/timbang_detail.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timbang_detail_event.dart';
part 'timbang_detail_state.dart';

class TimbangDetailBloc extends Bloc<TimbangDetailEvent, TimbangDetailState> {
  TimbangDetailBloc() : super(TimbangDetailInitial()) {
    on<TambahDetailTimbangEvent>(onTambahTimbang);
    on<SetTimbangProdukEvent>(onSetProduk);
    on<TimbangUlangSebelumnya>(onTimbangUlang);
  }

  FutureOr<void> onTambahTimbang(
      TambahDetailTimbangEvent event, Emitter<TimbangDetailState> emit) async {
    var timbangDetail = event.detail;
    await timbangDetail.save();
    emit(SelectedProductState(
        event.produk, [...state.listDetail, timbangDetail]));
  }

  void onSetProduk(
      SetTimbangProdukEvent event, Emitter<TimbangDetailState> emit) async {
    emit(SelectedProductState(event.produk, event.produk.listTimbangDetail));
  }

  FutureOr<void> onTimbangUlang(
      TimbangUlangSebelumnya event, Emitter<TimbangDetailState> emit) async {
    var previousDetail = await TimbangDetail.getPreviousDetail(event.produk.id);

    if (previousDetail != null) {
      var newListDetail = [...state.listDetail];
      newListDetail.removeLast();
      emit(PreviousTimbangDetailState(
          event.produk, newListDetail, previousDetail));
    } else {
      emit(SelectedProductState(event.produk, state.listDetail));
    }
  }
}
