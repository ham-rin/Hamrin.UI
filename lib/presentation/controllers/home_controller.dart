import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/core/constants/colors.dart';
import 'package:hamrin_app/data/models/hub/found_hamrin.dart';
import 'package:hamrin_app/data/models/hub/hamrin_invitation.dart';
import 'package:hamrin_app/data/models/hub/invitation_accepted.dart';
import 'package:hamrin_app/data/services/location_service.dart';
import 'package:hamrin_app/data/services/waiting_hub_client.dart';
import 'package:hamrin_app/presentation/routes/app_routes.dart';
import 'package:latlong2/latlong.dart';

class HomeController extends GetxController {
  final _client = WaitingHubClient();
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

    _client.addHamrinFoundHandler(
        (user) => hamrinFound(FoundHamrin.fromJson(user[0])));

    _client.addInvitationReceivedHandler((invitation) =>
        invitationHandler(HamrinInvitation.formJson(invitation[0])));

    _client.addInvitationAcceptedResultReceivedMethod(
        (ia) => invitationAcceptedHandler(InvitationAccepted.formJson(ia[0])));

    _client.addDeclinedInvitationResultReceivedMethod(
        (p0) => invitationDeclinedHandler(p0[0]));

    _client.addHamrinLeftHandler((userId) => removeHamrin(userId[0]));

    await _client.createGroup(point);
  }

  hamrinFound(foundUser) {
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
    await _client.inviteHamrin(hamrinId, await _locationService.getLocation());
    Get.snackbar("Invitation sent", "Invitation sent successfully!");
  }

  invitationHandler(HamrinInvitation invitation) async {
    final pin =
        LatLng(invitation.location.latitude, invitation.location.longitude);
    await Get.defaultDialog(
      title: "Hamrin Invitation",
      textConfirm: "Accept",
      textCancel: "Decline",
      onConfirm: () => acceptInvitation(invitation),
      onCancel: () => declineInvitation(invitation),
      content: SizedBox(
        width: 300,
        height: 300,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.green,
                child: Text(
                  "Invitation received from ${invitation.name}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    center: pin,
                    zoom: 16.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: pin,
                          builder: (ctx) => const Icon(
                            Icons.location_pin,
                            size: 40.0,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "${invitation.distance} meters away",
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
      backgroundColor: AppColors.modernBrownMaterialColor,
      radius: 10.0,
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      confirmTextColor: Colors.green,
      cancelTextColor: Colors.red,
    );
  }

  acceptInvitation(HamrinInvitation invitation) async {
    await _client.acceptInvitation(
        invitation.id, await _locationService.getLocation());

    Get.offNamed(AppRoutes.tracking,
        arguments: InvitationAccepted(invitation.name, invitation.location));
  }

  declineInvitation(HamrinInvitation invitation) async {
    await _client.declineInvitation(invitation.id);
  }

  invitationAcceptedHandler(InvitationAccepted ia) {
    Get.offNamed(AppRoutes.tracking, arguments: ia);
  }

  invitationDeclinedHandler(String name) {
    Get.snackbar("Invitation declined",
        "Unfortunately $name has declined you invite :(");
  }

  removeHamrin(String userId) {
    int index = -1;
    index = foundHamrins.indexWhere((hamrin) => hamrin.id == userId);
    if (index >= 0) {
      foundHamrins.removeAt(index);
      update();
    }
  }
}
