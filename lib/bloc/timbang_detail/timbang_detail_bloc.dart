import 'package:aplikasi_timbang/data/models/produk.dart';
import 'package:aplikasi_timbang/data/models/timbang_detail.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timbang_detail_event.dart';
part 'timbang_detail_state.dart';

class TimbangDetailBloc extends Bloc<TimbangDetailEvent, TimbangDetailState> {
  TimbangDetailBloc() : super(TimbangDetailInitial(const [])) {
    on<TambahDetailTimbangEvent>(onTambahTimbang);
    on<SetTimbangProdukEvent>(onSetProduk);
  }

  onTambahTimbang(
      TambahDetailTimbangEvent event, Emitter<TimbangDetailState> emit) async {
    var timbangDetail = event.detail;
    await timbangDetail.save();
    emit(SelectedProductState(
        event.produk, [...state.listDetail, timbangDetail]));
  }

  void onSetProduk(
      SetTimbangProdukEvent event, Emitter<TimbangDetailState> emit) async {
    emit(SelectedProductState(event.produk, state.listDetail));
  }
}
