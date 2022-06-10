part of 'so_bloc.dart';

abstract class SoState extends Equatable {
  const SoState(this.listDetail);

  final List<TimbangDetail> listDetail;

  @override
  List<Object> get props => [listDetail];
}

class SoInitial extends SoState {
  SoInitial() : super([]);
}

class SoLoading extends SoState {
  const SoLoading(List<TimbangDetail> listDetail) : super(listDetail);
}

class SoLoaded extends SoState {
  final Timbang timbang;

  SoLoaded(this.timbang) : super([]);

  @override
  List<Object> get props => [timbang];
}

class SoNotFound extends SoState {
  final int id;
  final String message;
  const SoNotFound({
    required this.id,
    required this.message,
    required List<TimbangDetail> listDetail,
  }) : super(listDetail);

  @override
  List<Object> get props => [id, message];
}

class SelectedProductState extends SoState {
  final TimbangProduk produk;
  final Timbang timbang;

  const SelectedProductState(
      this.timbang, this.produk, List<TimbangDetail> listDetail)
      : super(listDetail);
}

class PreviousTimbangDetailState extends SoState {
  final TimbangProduk produk;
  final TimbangDetail previous;
  final Timbang timbang;

  const PreviousTimbangDetailState(
    this.timbang,
    this.produk,
    List<TimbangDetail> listDetail,
    this.previous,
  ) : super(listDetail);
}

class TimbangProdukSelesaiState extends SoState {
  final TimbangProduk produk;
  final Timbang timbang;
  const TimbangProdukSelesaiState(
    this.timbang,
    this.produk,
    listDetail,
  ) : super(listDetail);
}

class UploadBuktiErrorState extends SoState {
  final TimbangProduk produk;
  final Timbang timbang;
  final String errorMessage;
  const UploadBuktiErrorState(
    this.timbang,
    this.produk,
    this.errorMessage,
    listDetail,
  ) : super(listDetail);
}

class SoComplete extends SoState {
  SoComplete() : super([]);
}
