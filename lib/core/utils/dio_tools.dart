import 'package:dio/dio.dart';
import 'package:hamrin_app/core/constants/app_constants.dart';
import 'package:hamrin_app/data/services/authentication_service.dart';

import '../../data/services/token_service.dart';

class DioTools{
  static Dio getDioInstance(String url) {
    var dio = Dio(BaseOptions(baseUrl: AppConstants.apiUrl + url));
    dio.options.validateStatus = (status) => status! < 500;
    dio.interceptors.add(InterceptorsWrapper(onError: (e, handler) async {
      if (e.response?.statusCode == 401 && await TokenService().token != null) {
        return await renewRequest(e, handler);
      }
      handler.next(e);
    }, onRequest: (options, handler) async {
      var token = await TokenService().token;
      if (token != null) options.headers["Authorization"] = "Bearer $token";
      handler.next(options);
    }));
    return dio;
  }

  static Future<void> renewRequest(
      DioError e, ErrorInterceptorHandler handler) async {
    var dio = Dio();
    var token = await refreshToken(dio);
    if (token == null) return handler.next(e);
    var path = e.requestOptions.path;
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.baseUrl = e.requestOptions.baseUrl;
    var response = await dio.request(path,
        options: Options(method: e.requestOptions.method),
        data: e.requestOptions.data,
        queryParameters: e.requestOptions.queryParameters);
    return handler.resolve(response);
  }

  static Future<String?> refreshToken(Dio dio) async {
    var ts = TokenService();
    var token = await ts.token;
    var refreshToken = await ts.refreshToken;
    var result = await AuthenticationService().refreshToken(dio, token!, refreshToken!);
    if (result == null) return null;
    ts.writeToken(result.token, result.refreshToken);
    return result.token;
  }
}