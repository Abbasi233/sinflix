import '/core/service_locator.dart';
import '/core/storage/local_storage_service.dart';

class SessionEntity {
  String? id;
  String? name;
  String? email;
  String? photoUrl;
  String? token;

  SessionEntity({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.token,
  });

  String get bearerToken => 'Bearer $token';
  bool get isAuthenticated => token?.isNotEmpty ?? false;

  void update({
    required String id,
    required String name,
    required String email,
    required String photoUrl,
    required String token,
  }) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.photoUrl = photoUrl;
    this.token = token;
    _saveToStorage();
  }

  void clear() {
    id = null;
    name = null;
    email = null;
    photoUrl = null;
    token = null;
    _clearStorage();
  }

  Future<void> loadFromStorage() async {
    final storage = sl<LocalStorageService>();
    token = await storage.getString(StorageKey.token.name);
  }

  Future<void> _saveToStorage() async {
    final storage = sl<LocalStorageService>();
    await storage.setString(StorageKey.token.name, token ?? '');
  }

  Future<void> _clearStorage() async {
    final storage = sl<LocalStorageService>();
    await storage.remove(StorageKey.token.name);
  }
}
