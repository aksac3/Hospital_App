import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _tokenKey = 'token'; 

  final SharedPreferences prefs;

  LocalStorage({required this.prefs});

  Future<void> saveToken(String token) async {
    await prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    await prefs.remove(_tokenKey);
  }
}