import 'package:aplikasi_timbang/data/services/response.dart';
import 'package:aplikasi_timbang/utils/constants.dart';
import 'package:dio/dio.dart';

import '../responses/error_response.dart';
import '../responses/login_response.dart';

class AuthService {
  Future<ApiResponse<LoginResponse?>> login(
      String email, String password) async {
    try {
      var response = await Dio().post(baseUrl + '/auth/login',
          data: {'email': email, 'password': password});

      var loginResponse = LoginResponse.fromJson(response.data);

      return ApiResponse(
        success: true,
        data: loginResponse,
        responseCode: response.statusCode ?? 200,
        message: 'Success login',
      );
    } on DioError catch (e) {
      var errorResponse = e.response;
      if (errorResponse != null) {
        var errorMessage = ApiErrorResponse.fromJson(errorResponse.data);

        return ApiResponse(
          success: false,
          data: null,
          responseCode: e.response?.statusCode ?? 500,
          message: errorMessage.message ?? '',
        );
      }
      return ApiResponse(
        success: false,
        data: null,
        responseCode: 500,
        message: 'Gagal login: ' + e.message,
      );
    }
  }
}
