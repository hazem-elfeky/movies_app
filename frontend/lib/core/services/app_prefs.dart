import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  Future<void> saveUserData({
    required String id,
    required String username,
    required String email,
    required String token,
  }) async {
    await _prefs.setString('id', id);
    await _prefs.setString('username', username);
    await _prefs.setString('email', email);
    await _prefs.setString('token', token);
    await _prefs.setBool('is_logged_in', true);
  }

  String? getUserId() => _prefs.getString('id');
  String? getUsername() => _prefs.getString('username');
  String? getUserEmail() => _prefs.getString('email');
  String? getToken() => _prefs.getString('token');

  bool get isLoggedIn => _prefs.getBool('is_logged_in') ?? false;

  Future<void> clearUserData() async {
    await _prefs.clear();
  }

  Map<String, String> getAuthHeaders() {
    final token = getToken();
    if (token != null && token.isNotEmpty) {
      return {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
    } else {
      return {'Content-Type': 'application/json'};
    }
  }

  Future<void> setString(String key, String value) async =>
      await _prefs.setString(key, value);
  String? getString(String key) => _prefs.getString(key);

  Future<void> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);
  bool? getBool(String key) => _prefs.getBool(key);

  Future<void> remove(String key) async => await _prefs.remove(key);
}
