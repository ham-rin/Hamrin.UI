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
    return const Scaffold(body: Center(child: Text("Home")));
  }
}
