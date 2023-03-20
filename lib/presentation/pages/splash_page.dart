import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/presentation/controllers/splash_controller.dart';
import 'package:hamrin_app/presentation/routes/app_routes.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.login);
    });

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'Welcome to hamrin :)',
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Obx(() => Text("version ${controller.version}"))),
        ],
      )),
    );
  }
}
