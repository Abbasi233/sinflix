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
  }

  void clear() {
    id = null;
    name = null;
    email = null;
    photoUrl = null;
    token = null;
  }
}
