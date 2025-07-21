import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'local_storage_service.dart';

class SecureStorageService implements LocalStorageService {
  static SecureStorageService? _instance;
  late FlutterSecureStorage _storage;

  SecureStorageService._internal();

  static SecureStorageService get instance {
    _instance ??= SecureStorageService._internal();
    return _instance!;
  }

  factory SecureStorageService() => instance;

  Future<void> init() async {
    _storage = const FlutterSecureStorage();
  }

  @override
  Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
    return true;
  }

  @override
  Future<bool?> getBool(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;
    return value == 'true';
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
    return true;
  }

  @override
  Future<int?> getInt(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;
    return int.tryParse(value);
  }

  @override
  Future<bool> setInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
    return true;
  }

  @override
  Future<bool> remove(String key) async {
    await _storage.delete(key: key);
    return true;
  }

  @override
  Future<bool> clear() async {
    await _storage.deleteAll();
    return true;
  }
}
