import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:aplikasi_timbang/data/models/timbang_detail.dart';
import 'package:equatable/equatable.dart';

class TimbangState extends Equatable {
  const TimbangState();

  @override
  List<Object?> get props => [];
}

class TimbangLoading extends TimbangState {}

class TimbangLoaded extends TimbangState {
  final List<Timbang> listTimbang;

  TimbangLoaded(this.listTimbang);

  List<Object?> get props => [listTimbang];
}
