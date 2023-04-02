import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/data/services/location_service.dart';
import 'package:hamrin_app/data/services/signalr_client.dart';

class HomeController extends GetxController {
  final _client = SignalRClient();
  final _locationService = LocationService();
  var isLocationPermissionOk = true.obs;

  requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    isLocationPermissionOk.value =
        permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always;
  }

  findHamrin() async {
    var point = await _locationService.getLocation();
    await _client.startConnection();
    _client.createGroup(point);
    _client.addHamrinFoundHandler((user) => {
      print(user)
    });
  }
}
