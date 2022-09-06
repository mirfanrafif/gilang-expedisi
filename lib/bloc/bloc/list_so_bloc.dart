import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/produk.dart';
import '../../data/models/timbang.dart';
import '../../data/models/timbang_detail.dart';
import '../../data/repository/so_repository.dart';
import '../../data/repository/user_repository.dart';

part 'list_so_event.dart';
part 'list_so_state.dart';

class ListSoBloc extends Bloc<ListSoEvent, ListSoState> {
  ListSoBloc() : super(ListSoInitial()) {
    on<GetSoByUserIdEvent>(onGetSoById);
  }

  var soRepository = SoRepository();
  var userRepository = UserRepository();

  void onGetSoById(GetSoByUserIdEvent event, Emitter<ListSoState> emit) async {
    emit(ListSoLoading());
    var token = userRepository.getToken();
    var user = userRepository.getUser();
    var response = await soRepository.getJobById(user.id, token ?? '');

    if (!response.success && response.responseCode == 401) {
      var currentUser = userRepository.getUser();
      var newToken =
          await userRepository.login(currentUser.email, currentUser.password);

      userRepository.saveToken(newToken.data?.accessToken ?? '');

      token = userRepository.getToken();
      response = await soRepository.getJobById(user.id, token ?? '');
    }

    if (!response.success) {
      //TODO: Benerin konversi response
      emit(ListSoError(
        message: response.message,
      ));
      return;
    }
    var data = response.data!.data;

    List<Timbang> listTimbang = [];

    for (var job in data) {
      //hasil dari cari PO
      var newTimbang = await Timbang.findById(job.soId ?? 0);

      //mencari data di sqlite, jika sudah ada ambil disana aja
      if (newTimbang == null) {
        newTimbang = Timbang(
          job.id ?? 0,
          job.soId ?? 0,
          user.id,
          job.so?.customer?.fullName ?? '',
          job.so?.shippingAddress ?? '',
          job.so?.transactionDate ?? DateTime.now(),
        );
        await newTimbang.save();
      }

      //karena di setiap PO ada produk yang ditimbang, contoh ayam hidup, maka buatkan classnya juga
      for (var produk in (job.so?.products ?? [])) {
        var newProduk = await TimbangProduk.findById(produk.id ?? 0);
        if (newProduk == null) {
          newProduk = TimbangProduk(
              produk.id ?? 0,
              produk.product?.name ?? '',
              produk.amount?.toInt() ?? 0,
              produk.amount?.toInt() ?? 0,
              produk.description,
              newTimbang.id);
          await newProduk.save();
        }
        var timbangDetail = await TimbangDetail.getByProdukId(newProduk.id);
        newProduk.listTimbangDetail = timbangDetail;
        newTimbang.tambahProduk(newProduk);
      }

      listTimbang.add(newTimbang);
    }

    //atur sesi timbang
    emit(ListSoLoaded(listTimbang));
  }
}
