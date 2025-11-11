import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const _keyRemember = "remember_me";
  static const _keyUserId = "user_id";
  static const _keyUserName = "user_name";

  static Future<void> saveUser(String id, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRemember, true);
    await prefs.setString(_keyUserId, id);
    await prefs.setString(_keyUserName, name);
  }

  static Future<Map<String, String>?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final remember = prefs.getBool(_keyRemember) ?? false;

    if (!remember) return null;

    final id = prefs.getString(_keyUserId);
    final name = prefs.getString(_keyUserName);

    if (id != null && name != null) {
      return {"id": id, "name": name};
    }
    return null;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
