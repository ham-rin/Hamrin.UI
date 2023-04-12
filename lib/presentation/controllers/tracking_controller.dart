import 'dart:async';

import 'package:get/get.dart';
import 'package:hamrin_app/data/models/hub/invitation_accepted.dart';
import 'package:hamrin_app/data/models/hub/user_location.dart';
import 'package:hamrin_app/data/services/location_hub_client.dart';
import 'package:hamrin_app/data/services/location_service.dart';

class TrackingController extends GetxController {
  final LocationHubClient _client = LocationHubClient();
  final LocationService _locationService = LocationService();
  final InvitationAccepted _invitationAccepted;
  late var latitude = 0.0.obs;
  late var longitude = 0.0.obs;
  final isBlinking = false.obs;

  TrackingController(this._invitationAccepted);

  @override
  void onInit() {
    latitude.value = _invitationAccepted.location.latitude;
    longitude.value = _invitationAccepted.location.longitude;
    handleClient();
    Timer.periodic(const Duration(seconds: 1), (_) {
      isBlinking.toggle();
      update();
    });
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      _client.updateLocation(await _locationService.getLocation());
    });
    super.onInit();
  }

  Future handleClient() async {
    await _client.startConnection();
    _client.addLocationUpdatedHandler(
        (ul) => handleLocationUpdated(UserLocation.formJson(ul[0])));
  }

  handleLocationUpdated(UserLocation userLocation) {
    latitude.value = userLocation.location.latitude;
    longitude.value = userLocation.location.longitude;
    update();
  }
}
