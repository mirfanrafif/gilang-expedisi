part of 'so_bloc.dart';

abstract class SoEvent extends Equatable {
  const SoEvent();

  @override
  List<Object> get props => [];
}

class CariSoEvent extends SoEvent {
  final int id;
  const CariSoEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class ProcessJobEvent extends SoEvent {
  TimbangProduk produk;
  Timbang timbang;
  List<TimbangDetail> listDetail;
  ProcessJobEvent(this.timbang, this.produk, this.listDetail);

  @override
  List<Object> get props => [produk, listDetail];
}

class SetTimbangProdukEvent extends SoEvent {
  final TimbangProduk produk;
  final Timbang timbang;
  const SetTimbangProdukEvent(this.timbang, this.produk);
}

class TambahDetailTimbangEvent extends SoEvent {
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

class TimbangUlangSebelumnya extends SoEvent {
  final TimbangProduk produk;
  final Timbang timbang;
  const TimbangUlangSebelumnya(
    this.timbang,
    this.produk,
  );

  @override
  List<Object> get props => [produk];
}

class KirimBuktiVerifikasiEvent extends SoEvent {
  final TimbangProduk produk;
  final File bukti;
  final Timbang timbang;

  const KirimBuktiVerifikasiEvent(
    this.timbang,
    this.produk,
    this.bukti,
  );
}

class CompleteJobEvent extends SoEvent {
  final Timbang timbang;
  const CompleteJobEvent(this.timbang);
}

class GetSessionEvent extends SoEvent {}

class ResetSoEvent extends SoEvent {}
