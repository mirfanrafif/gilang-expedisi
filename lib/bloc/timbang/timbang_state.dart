import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:equatable/equatable.dart';

class TimbangState extends Equatable {
  const TimbangState();

  @override
  List<Object?> get props => [];
}

class TimbangLoading extends TimbangState {}

class TimbangLoaded extends TimbangState {
  final List<Timbang> listTimbang;

  const TimbangLoaded(this.listTimbang);

  @override
  List<Object?> get props => [listTimbang];
}
