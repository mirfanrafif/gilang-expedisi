import 'package:aplikasi_timbang/data/responses/cari_so_response.dart';
import 'package:aplikasi_timbang/data/services/response.dart';
import 'package:aplikasi_timbang/data/services/so_service.dart';

class SoRepository {
  var service = SoService();
  Future<ApiResponse<CariSoResponse?>> cariSo(int soId, String token) {
    return service.findSo(soId, token);
  }
}
