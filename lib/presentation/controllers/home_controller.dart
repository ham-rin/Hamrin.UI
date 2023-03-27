import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLocationPermissionOk = true.obs;

  requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    isLocationPermissionOk.value =
        permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always;
  }
}
