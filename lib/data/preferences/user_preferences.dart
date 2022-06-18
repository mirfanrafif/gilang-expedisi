import 'package:aplikasi_timbang/data/models/user.dart';

import 'base_preferences.dart';

class UserPreferences {
  final _id = "id";
  final _fullName = "full_name";
  final _email = "email";
  final _role = "role";
  final _profilePhoto = "profile_photo";
  final _jwtToken = "jwt_token";
  final _password = "password";
  var preferences = BasePreferences.preferences;

  UserEntity getUser() {
    var user = UserEntity(
      id: preferences.getInt(_id) ?? 0,
      fullName: preferences.getString(_fullName) ?? "",
      email: preferences.getString(_email) ?? "",
      role: preferences.getString(_role) ?? "",
      profilePhoto: preferences.getString(_profilePhoto),
      password: preferences.getString(_password) ?? "",
    );
    return user;
  }

  void setUser(UserEntity user) {
    preferences.setInt(_id, user.id);
    preferences.setString(_fullName, user.fullName);
    preferences.setString(_email, user.email);
    preferences.setString(_role, user.role);
    preferences.setString(_profilePhoto, user.profilePhoto ?? "");
    preferences.setString(_password, user.password);
  }

  String? getToken() {
    return preferences.getString(_jwtToken);
  }

  void setToken(String token) async {
    preferences.setString(_jwtToken, token);
  }

  void logout() {
    preferences.clear();
  }
}
