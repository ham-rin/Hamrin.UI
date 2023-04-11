import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/data/models/users/found_hamrin.dart';
import 'package:hamrin_app/data/services/location_service.dart';
import 'package:hamrin_app/data/services/signalr_client.dart';

class HomeController extends GetxController {
  final _client = SignalRClient();
  final _locationService = LocationService();
  var isLocationPermissionOk = true.obs;
  final foundHamrins = <FoundHamrin>[].obs;

  requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    isLocationPermissionOk.value =
        permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always;
  }

  Future findHamrin() async {
    var point = await _locationService.getLocation();
    await _client.startConnection();
    _client.addHamrinFoundHandler((user) => hamrinFound(user));
    await _client.createGroup(point);
  }

  hamrinFound(user) {
    print(user);
    user = user[0];
    var foundUser = FoundHamrin.fromJson(user);
    int index = -1;
    index = foundHamrins.indexWhere((hamrin) => hamrin.id == foundUser.id);
    if (index >= 0) {
      foundHamrins[index] = foundUser;
    } else {
      foundHamrins.add(foundUser);
    }
    update();
  }

  Future inviteHamrin(String hamrinId) async {
    //Todo
  }
}
