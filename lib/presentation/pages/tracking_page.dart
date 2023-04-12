import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/presentation/controllers/tracking_controller.dart';
import 'package:latlong2/latlong.dart';

class TrackingPage extends StatelessWidget {
  TrackingPage({Key? key}) : super(key: key);

  var controller = Get.put(TrackingController(Get.arguments));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          interactiveFlags: InteractiveFlag.all,
          center: LatLng(controller.latitude.value, controller.longitude.value),
          zoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          Obx(
            () => MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(
                      controller.latitude.value, controller.longitude.value),
                  builder: (ctx) => controller.isBlinking.value
                      ? const Icon(Icons.flag_rounded,
                          color: Colors.red, size: 50)
                      : const Icon(Icons.flag_rounded,
                          color: Colors.white, size: 50),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
