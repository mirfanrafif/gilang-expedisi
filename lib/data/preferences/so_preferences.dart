import 'package:aplikasi_timbang/data/preferences/base_preferences.dart';

class SoPreferences {
  final _preferences = BasePreferences.preferences;
  final _currentTimbang = 'current_timbang_session';
  void setTimbangSession(int timbangId) {
    _preferences.setInt(_currentTimbang, timbangId);
  }

  int? get timbangSession => _preferences.getInt(_currentTimbang);
}
