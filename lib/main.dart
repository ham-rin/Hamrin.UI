import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/core/constants/colors.dart';
import 'package:hamrin_app/presentation/routes/app_pages.dart';
import 'package:hamrin_app/presentation/routes/app_routes.dart';

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
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: AppColors.modernYellowMaterialColor,
              accentColor: AppColors.modernBrownMaterialColor,
              brightness: Brightness.dark),
          scaffoldBackgroundColor: AppColors.modernBrown),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages.toList(),
    );
  }
}
