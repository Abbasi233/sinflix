import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/storage/local_storage_service.dart';

class SharedPreferencesService implements LocalStorageService {
  static SharedPreferencesService? _instance;
  late SharedPreferences _preferences;

  SharedPreferencesService._internal();

  static SharedPreferencesService get instance {
    _instance ??= SharedPreferencesService._internal();
    return _instance!;
  }

  factory SharedPreferencesService() => instance;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<String?> getString(String key) async {
    return _preferences.getString(key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _preferences.getBool(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _preferences.getInt(key);
  }

  @override
  Future<bool> setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  @override
  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  @override
  Future<bool> clear() async {
    return await _preferences.clear();
  }
}
