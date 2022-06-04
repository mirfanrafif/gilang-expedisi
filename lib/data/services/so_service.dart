import 'package:aplikasi_timbang/data/responses/cari_so_response.dart';
import 'package:aplikasi_timbang/data/responses/error_response.dart';
import 'package:aplikasi_timbang/data/services/response.dart';
import 'package:aplikasi_timbang/utils/constants.dart';
import 'package:dio/dio.dart';

class SoService {
  Future<ApiResponse<CariSoResponse?>> findSo(int soId, String token) async {
    try {
      var response = await Dio().get(
        BASE_URL + '/job/find-so',
        queryParameters: {'search': soId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ' + token,
          },
        ),
      );

      if ((response.statusCode ?? 500) < 400) {
        var result = ApiResponse(
            success: true,
            data: CariSoResponse.fromJson(response.data),
            message: 'Sukses mencari SO');
        return result;
      } else {
        var errorResponse = ApiErrorResponse.fromJson(response.data);
        var result = ApiResponse(
            success: true,
            data: null,
            message: 'Gagal mencari SO: ' + (errorResponse.message ?? ''));

        return result;
      }
    } catch (e) {
      var result = ApiResponse(
          success: true,
          data: null,
          message: 'Gagal mencari SO: ' + e.toString());
      return result;
    }
  }
}