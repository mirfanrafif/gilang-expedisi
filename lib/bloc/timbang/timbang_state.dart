import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:equatable/equatable.dart';

class TimbangState extends Equatable {
  List<Timbang> listTimbang = [];

  TimbangState(this.listTimbang);

  @override
  // TODO: implement props
  List<Object?> get props => [listTimbang];
}
