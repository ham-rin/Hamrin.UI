import 'package:dio/dio.dart';
import 'package:hamrin_app/core/constants/app_constants.dart';
import 'package:hamrin_app/core/utils/dio_tools.dart';

import '../models/authentication/auth_response.dart';
import '../models/authentication/login_model.dart';
import '../models/authentication/refresh_token_model.dart';

class AuthenticationService {
  static final Dio _dio = DioTools.getDioInstance("auth/");

  Future<AuthResponse> login(String email, String password) async {
    var model = LoginModel(email, password);
    var response = await _dio.post("login", data: model.toJson());
    var output = AuthResponse.fromJson(response.data);
    return output;
  }

  Future<RefreshTokenModel?> refreshToken(
      Dio client, String token, String refreshToken) async {
    var refreshTokenModel = RefreshTokenModel(token, refreshToken);
    try {
      var result = await client.post(
          "${AppConstants.apiUrl}auth/api/Auth/RefreshToken",
          data: refreshTokenModel);
      var output = AuthResponse.fromJson(result.data);
      return RefreshTokenModel(output.token, output.refreshToken);
    } on DioError catch (e) {
      var error = e.error;
      var data = e.response?.data;
      if (e.response != null && e.response!.statusCode == 400) return null;
      rethrow;
    }
  }
}