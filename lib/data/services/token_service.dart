import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static String? _token;
  static String? _refreshToken;

  static const storage = FlutterSecureStorage();

  Future<String?> get token async => _token ??= await readToken();

  Future<String?> get refreshToken async =>
      _refreshToken ??= await readRefreshToken();

  writeToken(String token, String refreshToken) async {
    await storage.write(key: "token", value: token);
    await storage.write(key: "refreshToken", value: refreshToken);
    _token = token;
    _refreshToken = refreshToken;
  }

  Future<String?> readToken() async {
    var token = await storage.read(key: "token");
    _token = token;
    return token;
  }

  Future<String?> readRefreshToken() async {
    var refreshToken = await storage.read(key: "refreshToken");
    _refreshToken = refreshToken;
    return refreshToken;
  }

  Future remove() async {
    await storage.delete(key: "token");
    await storage.delete(key: "refreshToken");
    _token = null;
    _refreshToken = null;
  }
}
