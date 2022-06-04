import 'package:aplikasi_timbang/data/models/produk.dart';
import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:aplikasi_timbang/data/services/so_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'so_event.dart';
part 'so_state.dart';

class SoBloc extends Bloc<SoEvent, SoState> {
  var service = SoService();

  SoBloc() : super(SoInitial()) {
    on<CariSoEvent>(onCariSo);
  }

  void onCariSo(CariSoEvent event, Emitter<SoState> emit) async {
    emit(SoLoading());
    var response = await service.findSo(event.id, event.token);

    if (!response.success) {
      emit(SoNotFound(id: event.id));
      return;
    }
    var data = response.data!.data;

    if (data.isEmpty) {
      emit(SoNotFound(id: event.id));
      return;
    }

    var timbang = data.first;

    //hasil dari cari SO
    var so = Timbang(timbang.id ?? 0, 123, timbang.customer?.fullName ?? '',
        timbang.shippingAddress ?? '');
    await so.save();

    //karena di setiap SO ada produk yang ditimbang, contoh ayam hidup, maka buatkan classnya juga
    for (var produk in timbang.products) {
      var ayamHidup = TimbangProduk('Ayam Hidup', 1000, 500, null, so.id!);
      await ayamHidup.save();
      so.tambahProduk(ayamHidup);
    }

    emit(SoLoaded(so));
  }
}
