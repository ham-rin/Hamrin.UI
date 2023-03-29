import 'package:hamrin_app/data/services/storage_service.dart';

class TokenService {
  static String? _token;
  static String? _refreshToken;

  var storageService = StorageService();

  Future<String?> get token async => _token ??= await readToken();

  Future<String?> get refreshToken async =>
      _refreshToken ??= await readRefreshToken();

  writeToken(String token, String refreshToken) async {
    await storageService.write("token", token);
    await storageService.write("refreshToken", refreshToken);
    _token = token;
    _refreshToken = refreshToken;
  }

  Future<String?> readToken() async {
    var token = await storageService.read("token");
    _token = token;
    return token;
  }

  Future<String?> readRefreshToken() async {
    var refreshToken = await storageService.read("refreshToken");
    _refreshToken = refreshToken;
    return refreshToken;
  }

  Future remove() async {
    await storageService.remove("token");
    await storageService.remove("refreshToken");
    _token = null;
    _refreshToken = null;
  }
}
