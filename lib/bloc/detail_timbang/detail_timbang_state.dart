part of 'detail_timbang_bloc.dart';

abstract class DetailTimbangState extends Equatable {
  final List<TimbangDetail> listDetail;

  const DetailTimbangState(this.listDetail);

  @override
  List<Object> get props => [listDetail];
}

class DetailTimbangInitial extends DetailTimbangState {
  DetailTimbangInitial() : super([]);
}

class SelectedProductState extends DetailTimbangState {
  final TimbangProduk produk;
  final Timbang timbang;

  const SelectedProductState(
      this.timbang, this.produk, List<TimbangDetail> listDetail)
      : super(listDetail);
}

class PreviousTimbangDetailState extends DetailTimbangState {
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

class UploadingBuktiTimbangState extends DetailTimbangState {
  final TimbangProduk produk;
  final Timbang timbang;

  const UploadingBuktiTimbangState(this.timbang, this.produk, listDetail)
      : super(listDetail);
}

class UpdateTimbangDetailState extends DetailTimbangState {
  final TimbangProduk produk;
  final TimbangDetail selected;
  final int position;
  final Timbang timbang;

  const UpdateTimbangDetailState(
    this.timbang,
    this.produk,
    List<TimbangDetail> listDetail,
    this.selected,
    this.position,
  ) : super(listDetail);
}

class DeleteTimbangDetailState extends DetailTimbangState {
  final TimbangProduk produk;
  final Timbang timbang;

  const DeleteTimbangDetailState(
    this.timbang,
    this.produk,
    List<TimbangDetail> listDetail,
  ) : super(listDetail);
}

class TimbangProdukSelesaiState extends DetailTimbangState {
  final TimbangProduk produk;
  final Timbang timbang;
  const TimbangProdukSelesaiState(
    this.timbang,
    this.produk,
    listDetail,
  ) : super(listDetail);
}

class UploadBuktiErrorState extends DetailTimbangState {
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

class ProcessJobSuccessState extends DetailTimbangState {
  final Timbang timbang;
  ProcessJobSuccessState(this.timbang) : super([]);
}

class ProcessJobErrorState extends DetailTimbangState {
  final String message;

  const ProcessJobErrorState(List<TimbangDetail> listDetail, this.message)
      : super(listDetail);
}
