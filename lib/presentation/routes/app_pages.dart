import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hamrin_app/presentation/pages/home_page.dart';
import 'package:hamrin_app/presentation/pages/login_page.dart';
import 'package:hamrin_app/presentation/pages/splash_page.dart';
import 'package:hamrin_app/presentation/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    ),
  ];
}