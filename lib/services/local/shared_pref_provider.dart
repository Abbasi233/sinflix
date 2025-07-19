import 'package:shared_preferences/shared_preferences.dart';

enum SharedKey {
  THEME,
  TOKEN,
  USER_DATA,
  IS_LOGGED_IN,
}

class SharedPrefProvider {
  static SharedPrefProvider? _instance;
  late SharedPreferences _preferences;

  SharedPrefProvider._internal();

  static SharedPrefProvider get I {
    _instance ??= SharedPrefProvider._internal();
    return _instance!;
  }

  factory SharedPrefProvider() => I;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getString(SharedKey key) => _preferences.getString(key.name);

  bool? getBool(SharedKey key) => _preferences.getBool(key.name);

  int? getInt(SharedKey key) => _preferences.getInt(key.name);

  Future<bool?> setString(SharedKey key, String value) {
    return _preferences.setString(key.name, value);
  }

  Future<bool?> setBool(SharedKey key, bool value) {
    return _preferences.setBool(key.name, value);
  }

  Future<bool?> setInt(SharedKey key, int value) {
    return _preferences.setInt(key.name, value);
  }

  Future<bool?> remove(SharedKey key) {
    return _preferences.remove(key.name);
  }

  Future<bool?> clear() {
    return _preferences.clear();
  }
}
