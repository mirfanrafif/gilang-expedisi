import 'package:aplikasi_timbang/bloc/timbang/timbang_event.dart';
import 'package:aplikasi_timbang/bloc/timbang/timbang_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimbangBloc extends Bloc<TimbangEvent, TimbangState> {
  TimbangBloc() : super(TimbangState([])) {
    on<TambahTimbangEvent>(
      (event, emit) =>
          emit(TimbangState([...state.listTimbang, event.newTimbang])),
    );
  }
}
