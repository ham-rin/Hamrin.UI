import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/presentation/pages/splash_page.dart';
import 'package:hamrin_app/presentation/routes/app_pages.dart';
import 'package:hamrin_app/presentation/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

const Color modernYellow = Color(0xFFFFC857);
const Color modernBrown = Color(0xFF4B3832);

final MaterialColor modernYellowMaterialColor =
    MaterialColor(modernYellow.value, const <int, Color>{
  50: Color(0xFFFFFCE5),
  100: Color(0xFFFFF9CC),
  200: Color(0xFFFFF299),
  300: Color(0xFFFFEE66),
  400: Color(0xFFFFE94D),
  500: modernYellow,
  600: Color(0xFFFFC13A),
  700: Color(0xFFFFB327),
  800: Color(0xFFFFA914),
  900: Color(0xFFFFA100),
});

final MaterialColor modernBrownMaterialColor =
    MaterialColor(modernBrown.value, const <int, Color>{
  50: Color(0xFFE8E3DF),
  100: Color(0xFFC8BFB8),
  200: Color(0xFFA6918F),
  300: Color(0xFF866266),
  400: Color(0xFF6E4E4B),
  500: modernBrown,
  600: Color(0xFF4E322A),
  700: Color(0xFF3C271D),
  800: Color(0xFF2A1C11),
  900: Color(0xFF180D06),
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hamrin',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: modernYellowMaterialColor,
              accentColor: modernBrownMaterialColor,
              brightness: Brightness.dark),
          scaffoldBackgroundColor: modernBrown),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages.toList(),
    );
  }
}
