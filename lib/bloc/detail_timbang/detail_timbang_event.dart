part of 'detail_timbang_bloc.dart';

abstract class DetailTimbangEvent extends Equatable {
  const DetailTimbangEvent();

  @override
  List<Object> get props => [];
}

class ProcessJobEvent extends DetailTimbangEvent {
  final TimbangProduk produk;
  final Timbang timbang;
  final List<TimbangDetail> listDetail;
  const ProcessJobEvent(this.timbang, this.produk, this.listDetail);

  @override
  List<Object> get props => [produk, listDetail];
}

class SetTimbangProdukEvent extends DetailTimbangEvent {
  final TimbangProduk produk;
  const SetTimbangProdukEvent(this.produk);
}

class TambahDetailTimbangEvent extends DetailTimbangEvent {
  final TimbangDetail detail;
  final TimbangProduk produk;
  const TambahDetailTimbangEvent(
    this.detail,
    this.produk,
  );

  @override
  List<Object> get props => [detail];
}

class TimbangUlangSebelumnya extends DetailTimbangEvent {
  final TimbangProduk produk;
  const TimbangUlangSebelumnya(
    this.produk,
  );

  @override
  List<Object> get props => [produk];
}

class KirimBuktiVerifikasiEvent extends DetailTimbangEvent {
  final TimbangProduk produk;
  final File bukti;

  const KirimBuktiVerifikasiEvent(
    this.produk,
    this.bukti,
  );
}

class UpdateTimbangDetailEvent extends DetailTimbangEvent {
  final TimbangDetail detail;
  final TimbangProduk produk;
  const UpdateTimbangDetailEvent(this.produk, this.detail);
}

class DeleteTimbangDetailEvent extends DetailTimbangEvent {
  final TimbangDetail detail;
  final TimbangProduk produk;
  const DeleteTimbangDetailEvent(this.produk, this.detail);
}

class SubmitUpdateTimbangEvent extends DetailTimbangEvent {
  final TimbangDetail detail;
  final TimbangProduk produk;
  final int position;
  const SubmitUpdateTimbangEvent(
    this.produk,
    this.detail,
    this.position,
  );
}
