import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class SplashController extends GetxController {
  var version = '0.0.0'.obs;

  @override
  void onInit() {
    setVersion();
    super.onInit();
  }

  setVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }
}
