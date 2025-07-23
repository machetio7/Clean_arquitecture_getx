import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  static const String tokenKey = 'token';

  /// Guarda por clave valor
  static Future<void> set(String key, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, token);
  }

  /// Obtiener valor por llave
  static Future<String?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// Elimina por llave
  static Future<void> clearPreferenceByKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

    /// Elimina por todo
  static Future<void> clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}