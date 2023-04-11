import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/presentation/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(context) {
    controller.requestLocationPermission();
    controller.findHamrin();
    return Scaffold(
      body: Obx(() => ListView.builder(
        itemCount: controller.foundHamrins.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(controller.foundHamrins[index].name),
            onTap: () => controller.inviteHamrin(controller.foundHamrins[index].id),
            subtitle: Text(
                '${controller.foundHamrins[index].distance} meters away'),
          );
        },
      )),
    );
  }
}
