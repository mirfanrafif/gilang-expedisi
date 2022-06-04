import 'package:aplikasi_timbang/data/models/produk.dart';
import 'package:aplikasi_timbang/data/models/timbang.dart';
import 'package:aplikasi_timbang/data/repository/so_repository.dart';
import 'package:aplikasi_timbang/data/repository/user_repository.dart';
import 'package:aplikasi_timbang/data/services/so_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'so_event.dart';
part 'so_state.dart';

class SoBloc extends Bloc<SoEvent, SoState> {
  var soRepository = SoRepository();
  var userRepository = UserRepository();

  SoBloc() : super(SoInitial()) {
    on<CariSoEvent>(onCariSo);
  }

  void onCariSo(CariSoEvent event, Emitter<SoState> emit) async {
    emit(SoLoading());
    var token = userRepository.getToken();
    var user = userRepository.getUser();
    var response = await soRepository.cariSo(event.id, token ?? '');

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
    var so = Timbang(
      timbang.id ?? 0,
      timbang.number ?? 0,
      user.id,
      timbang.customer?.fullName ?? '',
      timbang.shippingAddress ?? '',
    );
    await so.save();

    //karena di setiap SO ada produk yang ditimbang, contoh ayam hidup, maka buatkan classnya juga
    for (var produk in timbang.products) {
      var ayamHidup =
          TimbangProduk(produk.productName ?? '', 1000, 500, null, so.id!);
      await ayamHidup.save();
      so.tambahProduk(ayamHidup);
    }

    emit(SoLoaded(so));
  }
}
