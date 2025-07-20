abstract class LocalStorageService {
  Future<String?> getString(String key);
  Future<bool> setString(String key, String value);
  Future<bool?> getBool(String key);
  Future<bool> setBool(String key, bool value);
  Future<int?> getInt(String key);
  Future<bool> setInt(String key, int value);
  Future<bool> remove(String key);
  Future<bool> clear();
}

enum StorageKey {
  theme,
  token,
  userData,
  isLoggedIn,
}
