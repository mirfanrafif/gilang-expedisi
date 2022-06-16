part of 'detail_timbang_bloc.dart';

abstract class DetailTimbangEvent extends Equatable {
  const DetailTimbangEvent();

  @override
  List<Object> get props => [];
}

class ProcessJobEvent extends DetailTimbangEvent {
  TimbangProduk produk;
  Timbang timbang;
  List<TimbangDetail> listDetail;
  ProcessJobEvent(this.timbang, this.produk, this.listDetail);

  @override
  List<Object> get props => [produk, listDetail];
}

class SetTimbangProdukEvent extends DetailTimbangEvent {
  final TimbangProduk produk;
  final Timbang timbang;
  const SetTimbangProdukEvent(this.timbang, this.produk);
}

class TambahDetailTimbangEvent extends DetailTimbangEvent {
  final TimbangDetail detail;
  final TimbangProduk produk;
  final Timbang timbang;
  const TambahDetailTimbangEvent(
    this.timbang,
    this.detail,
    this.produk,
  );

  @override
  List<Object> get props => [detail];
}

class TimbangUlangSebelumnya extends DetailTimbangEvent {
  final TimbangProduk produk;
  final Timbang timbang;
  const TimbangUlangSebelumnya(
    this.timbang,
    this.produk,
  );

  @override
  List<Object> get props => [produk];
}

class KirimBuktiVerifikasiEvent extends DetailTimbangEvent {
  final TimbangProduk produk;
  final File bukti;
  final Timbang timbang;

  const KirimBuktiVerifikasiEvent(
    this.timbang,
    this.produk,
    this.bukti,
  );
}
