import 'package:aplikasi_timbang/bloc/so/so_bloc.dart';
import 'package:aplikasi_timbang/bloc/timbang/timbang_event.dart';
import 'package:aplikasi_timbang/bloc/timbang/timbang_state.dart';
import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:aplikasi_timbang/data/repository/so_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimbangBloc extends Bloc<TimbangEvent, TimbangState> {
  var soRepository = SoRepository();
  TimbangBloc() : super(TimbangLoading()) {
    on<LoadTimbangEvent>(
      (event, emit) async {
        var listTimbang = await soRepository.getHistoryTimbang();
        emit(TimbangLoaded(listTimbang));
      },
    );
  }
}
