import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/presentation/controllers/home_controller.dart';
import 'package:hamrin_app/presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hamrin',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color.fromARGB(1, 254, 216, 110),
          scaffoldBackgroundColor: const Color.fromARGB(255, 254, 216, 110)),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Obx(() => Text(
                "${controller.count}",
                style: Theme.of(context).textTheme.headlineMedium,
              )),
          OutlinedButton(
              onPressed: () => Get.to(LoginPage()),
              child: const Text("Increment")),
          OutlinedButton(
              onPressed: () => controller.reset(), child: const Text("Reset"))
        ],
      ),
    ));
  }
}
