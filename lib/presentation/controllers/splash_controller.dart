import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/core/utils/dio_tools.dart';
import 'package:hamrin_app/data/models/versions/app_version_model.dart';
import 'package:hamrin_app/data/models/versions/platform.dart';
import 'package:hamrin_app/data/models/versions/version_info_model.dart';
import 'package:hamrin_app/data/services/storage_service.dart';
import 'package:hamrin_app/data/services/token_service.dart';
import 'package:hamrin_app/data/services/version_service.dart';
import 'package:hamrin_app/presentation/routes/app_routes.dart';
import 'package:package_info/package_info.dart';

class SplashController extends GetxController {
  final VersionService _versionService = VersionService();
  final StorageService _storageService = StorageService();
  final _tokenService = TokenService();
  var version = '0.0.0'.obs;
  var shouldUpdate = false.obs;
  var canUpdate = false.obs;

  // ignore: unnecessary_cast
  var changeLog = (null as ChangeLog?).obs;

  @override
  void onInit() {
    DioTools.refreshToken().then((value) => handleRefreshTokenResponse(value));
    setVersion();
    getToPage();
    super.onInit();
  }

  getToPage() async {
    var token = await _tokenService.token;
    Future.delayed(const Duration(seconds: 2), () {
      if (token == null) {
        Get.offNamed(AppRoutes.login);
      } else {
        Get.offNamed(AppRoutes.home);
      }
    });
  }

  showVersionInfo() async {
    var key = "lastLoadedVersion";
    var lastLoadedVersion = await _storageService.read(key);
    if (lastLoadedVersion != null && lastLoadedVersion == version.value) {
      return;
    }
    var response =
        await _versionService.getVersionInfo(getPlatform(), version.value);
    changeLog.value = response.changeLog;
    await _storageService.write(key, version.value);
  }

  setVersion() async {
    var currentVersion = await getCurrentVersion();
    version.value = currentVersion;
    var appVersion = await getAppVersion();
    if (appVersion.latestAppVersion == currentVersion) {
      return;
    }

    if (!isCurrentVersionOk(
        currentVersion, appVersion.minimumMandatoryAppVersion)) {
      shouldUpdate.value = true;
    }
    shouldUpdate.value = true;
  }

  bool isCurrentVersionOk(String currentVersion, String mandatoryVersion) {
    var currentVersionArray = currentVersion.split('.');
    var currentMajor = int.parse(currentVersionArray[0]);
    var currentMinor = int.parse(currentVersionArray[1]);
    var currentPatch = int.parse(currentVersionArray[2]);

    var versionArray = mandatoryVersion.split('.');
    var mandatoryMajor = int.parse(versionArray[0]);
    var mandatoryMinor = int.parse(versionArray[1]);
    var mandatoryPatch = int.parse(versionArray[2]);

    return currentMajor >= mandatoryMajor &&
        currentMinor >= mandatoryMinor &&
        currentPatch >= mandatoryPatch;
  }

  Future<AppVersion> getAppVersion() async {
    var platform = getPlatform();
    var response = await _versionService.getAppVersion(platform);
    return response;
  }

  Future<String> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var currentVersion = packageInfo.version;
    return currentVersion;
  }

  AppPlatform getPlatform() {
    if (Platform.isAndroid) {
      return AppPlatform.android;
    }
    if (Platform.isIOS) {
      return AppPlatform.ios;
    } else {
      return AppPlatform.web;
    }
  }

  handleRefreshTokenResponse(String? value) {
    if(value == null){
      _tokenService.remove();
      Get.offNamed(AppRoutes.login);
    }
  }
}
