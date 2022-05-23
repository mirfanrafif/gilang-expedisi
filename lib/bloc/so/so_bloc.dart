import 'package:aplikasi_timbang/data/models/produk.dart';
import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'so_event.dart';
part 'so_state.dart';

class SoBloc extends Bloc<SoEvent, SoState> {
  SoBloc() : super(SoInitial()) {
    on<CariSoEvent>(onCariSo);
  }

  void onCariSo(CariSoEvent event, Emitter<SoState> emit) async {
    emit(SoLoading());
    await Future.delayed(const Duration(seconds: 1));

    //hasil dari cari SO
    var so = Timbang(11234, 123, 'RDN', 'Parung');
    await so.save();

    //karena di setiap SO ada produk yang ditimbang, contoh ayam hidup, maka buatkan classnya juga
    var ayamHidup = TimbangProduk('Ayam Hidup', 1000, 500, null, so.id!);
    await ayamHidup.save();
    so.tambahProduk(ayamHidup);

    emit(SoLoaded(so));
  }
}
