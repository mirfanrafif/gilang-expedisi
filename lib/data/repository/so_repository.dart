import 'package:aplikasi_timbang/data/preferences/so_preferences.dart';
import 'package:aplikasi_timbang/data/responses/cari_so_response.dart';
import 'package:aplikasi_timbang/data/services/response.dart';
import 'package:aplikasi_timbang/data/services/so_service.dart';

class SoRepository {
  var service = SoService();
  var preferences = SoPreferences();
  Future<ApiResponse<CariSoResponse?>> cariSo(int soId, String token) {
    return service.findSo(soId, token);
  }

  void setSession(int timbangId) {
    preferences.setTimbangSession(timbangId);
  }
}
