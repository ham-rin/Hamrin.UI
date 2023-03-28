import 'package:dio/dio.dart';
import 'package:hamrin_app/core/utils/dio_tools.dart';
import 'package:hamrin_app/data/models/version/app_version_model.dart';
import 'package:hamrin_app/data/models/version/platform.dart';
import 'package:hamrin_app/data/models/version/version_info_model.dart';

class VersionService {
  static final Dio _dio = DioTools.getDioInstance("version/");

  Future<AppVersion> getAppVersion(Platform platform) async {
    var response = await _dio
        .get("appVersion", queryParameters: {"platform": platform.index});
    var output = AppVersion.fromJson(response.data);
    return output;
  }

  Future<VersionInfo> getVersionInfo(Platform platform, String version) async {
    var response = await _dio.get("versionInfo/${platform.index}",
        queryParameters: {"version": version});
    var output = VersionInfo.fromJson(response.data);
    return output;
  }
}
