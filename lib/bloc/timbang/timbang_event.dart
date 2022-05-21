import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:equatable/equatable.dart';

class TimbangEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TambahTimbangEvent extends TimbangEvent {
  final Timbang newTimbang;
  TambahTimbangEvent(this.newTimbang);
}
