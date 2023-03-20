import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/data/services/authentication_service.dart';
import 'package:hamrin_app/data/services/token_service.dart';
import 'package:hamrin_app/presentation/pages/home_page.dart';
import 'package:hamrin_app/presentation/routes/app_routes.dart';

class SignupController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthenticationService authenticationService = AuthenticationService();

  var isLoading = false.obs;

  signup() async {
    if (!formKey.currentState!.validate()) return null;
    isLoading.value = true;
    try {
      var email = emailController.text;
      var password = passwordController.text;
      var response = await authenticationService.signup(email, password);
      if (response.succeeded) {
        Get.toNamed(AppRoutes.emailConfirmation, arguments: email);
      } else {
        Get.snackbar(
            "error", response.errors.map((e) => e.enError).toList().join('\n'));
      }
    } finally {
      isLoading.value = false;
    }
  }
}
