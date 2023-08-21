import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<String?> getString(String key);

  // bool getBoolean();

  Future<bool> setString(String key, String value);
// void setBoolean();
}

class SharedPrefs implements LocalStorage {
  @override
  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }
}
