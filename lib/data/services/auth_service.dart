import 'package:aplikasi_timbang/data/services/response.dart';
import 'package:aplikasi_timbang/utils/constants.dart';
import 'package:dio/dio.dart';

import '../responses/error_response.dart';
import '../responses/login_response.dart';

class AuthService {
  Future<ApiResponse<LoginResponse?>> login(
      String email, String password) async {
    try {
      var response = await Dio().post(BASE_URL + '/auth/login',
          data: {'email': email, 'password': password});

      var loginResponse = LoginResponse.fromJson(response.data);

      return ApiResponse(
        success: true,
        data: loginResponse,
        message: 'Success login',
      );
    } on DioError catch (e) {
      var errorResponse = e.response;
      if (errorResponse != null) {
        var errorMessage = ApiErrorResponse.fromJson(errorResponse.data);

        return ApiResponse(
          success: false,
          data: null,
          message: errorMessage.message ?? '',
        );
      }
      return ApiResponse(
        success: false,
        data: null,
        message: 'Gagal login: ' + e.message,
      );
    }
  }
}
