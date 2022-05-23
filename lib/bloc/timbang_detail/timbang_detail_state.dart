part of 'timbang_detail_bloc.dart';

abstract class TimbangDetailState extends Equatable {
  const TimbangDetailState(this.listDetail);

  final List<TimbangDetail> listDetail;

  @override
  List<Object> get props => [listDetail];
}

class TimbangDetailInitial extends TimbangDetailState {
  TimbangDetailInitial() : super([]);
}

class SelectedProductState extends TimbangDetailState {
  final TimbangProduk produk;

  const SelectedProductState(this.produk, List<TimbangDetail> listDetail)
      : super(listDetail);
}

class PreviousTimbangDetailState extends TimbangDetailState {
  final TimbangProduk produk;
  final TimbangDetail previous;

  const PreviousTimbangDetailState(
      this.produk, List<TimbangDetail> listDetail, this.previous)
      : super(listDetail);
}
