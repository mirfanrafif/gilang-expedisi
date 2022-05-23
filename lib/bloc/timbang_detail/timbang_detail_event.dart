part of 'timbang_detail_bloc.dart';

abstract class TimbangDetailEvent extends Equatable {
  const TimbangDetailEvent();

  @override
  List<Object> get props => [];
}

class SetTimbangProdukEvent extends TimbangDetailEvent {
  final TimbangProduk produk;
  const SetTimbangProdukEvent(this.produk);
}

class TambahDetailTimbangEvent extends TimbangDetailEvent {
  final TimbangDetail detail;
  final TimbangProduk produk;
  const TambahDetailTimbangEvent(this.detail, this.produk);

  @override
  List<Object> get props => [detail];
}

class TimbangUlangSebelumnya extends TimbangDetailEvent {
  final TimbangProduk produk;
  const TimbangUlangSebelumnya(this.produk);
}
