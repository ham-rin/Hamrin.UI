import 'package:dio/dio.dart';
import 'package:hamrin_app/core/constants/app_constants.dart';
import 'package:hamrin_app/core/utils/dio_tools.dart';
import 'package:hamrin_app/data/services/token_service.dart';

import '../models/authentications/auth_response.dart';
import '../models/authentications/email_confirmation_model.dart';
import '../models/authentications/login_model.dart';
import '../models/authentications/refresh_token_model.dart';

class AuthenticationService {
  static final Dio _dio = DioTools.getDioInstance("auth/");
  final TokenService _tokenService = TokenService();

  Future<AuthResponse> login(String email, String password) async {
    var model = LoginModel(email, password);
    var response = await _dio.post("login", data: model.toJson());
    var output = AuthResponse.fromJson(response.data);
    return output;
  }

  Future<AuthResponse> signup(String email, String password) async {
    var model = LoginModel(email, password);
    var response = await _dio.post("register", data: model);
    var output = AuthResponse.fromJson(response.data);
    return output;
  }

  Future<AuthResponse> confirmEmail(String email, String code) async {
    var model = EmailConfirmationModel(email, code);
    var response = await _dio.post("emailConfirmation", data: model.toJson());
    var output = AuthResponse.fromJson(response.data);
    return output;
  }

  Future<AuthResponse> resendEmail(String email) async {
    var response = await _dio.post("resendEmailConfirmation/$email");
    var output = AuthResponse.fromJson(response.data);
    return output;
  }

  Future<RefreshTokenModel?> refreshToken(
      Dio client, String token, String refreshToken) async {
    var refreshTokenModel = RefreshTokenModel(token, refreshToken);
    try {
      var result = await client.post("${AppConstants.apiUrl}Auth/RefreshToken",
          data: refreshTokenModel,
          options: Options(contentType: "application/json"));
      var output = AuthResponse.fromJson(result.data);
      return RefreshTokenModel(output.token, output.refreshToken);
    } on DioError catch (e) {
      var error = e.error;
      var data = e.response?.data;
      var errorCode = int.parse(data?["errors"]?[0]?["code"] ?? "-10");
      if (errorCode == 10) {
        return null;
      }
      if (errorCode == 11) {
        return RefreshTokenModel(
            (await _tokenService.token)!, (await _tokenService.refreshToken)!);
      }
      rethrow;
    }
  }
}
