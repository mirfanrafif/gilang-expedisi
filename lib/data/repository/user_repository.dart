import 'package:aplikasi_timbang/data/models/user.dart';
import 'package:aplikasi_timbang/data/preferences/user_preferences.dart';
import 'package:aplikasi_timbang/data/responses/login_response.dart';
import 'package:aplikasi_timbang/data/services/auth_service.dart';
import 'package:aplikasi_timbang/data/services/response.dart';

class UserRepository {
  var service = AuthService();
  var preferences = UserPreferences();

  Future<ApiResponse<LoginResponse?>> login(
      String username, String password) async {
    var response = await service.login(username, password);
    return response;
  }

  void saveUser(UserEntity user) {
    preferences.setUser(user);
  }

  void saveToken(String token) {
    preferences.setToken(token);
  }

  String? getToken() => preferences.getToken();

  UserEntity getUser() {
    return preferences.getUser();
  }

  void logout() {
    preferences.logout();
  }
}
