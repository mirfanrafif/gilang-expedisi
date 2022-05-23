import 'package:aplikasi_timbang/bloc/timbang/timbang_event.dart';
import 'package:aplikasi_timbang/bloc/timbang/timbang_state.dart';
import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimbangBloc extends Bloc<TimbangEvent, TimbangState> {
  TimbangBloc() : super(TimbangLoading()) {
    on<LoadTimbangEvent>(onLoadTimbang);
  }

  void onLoadTimbang(LoadTimbangEvent event, Emitter<TimbangState> emit) async {
    var result = await Timbang.getAll();
    emit(TimbangLoaded(result));
  }
}
