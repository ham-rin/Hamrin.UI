import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/data/services/authentication_service.dart';
import 'package:hamrin_app/data/services/token_service.dart';
import 'package:hamrin_app/presentation/pages/home_page.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthenticationService authenticationService = AuthenticationService();
  final TokenService tokenService = TokenService();

  var isLoading = false.obs;

  login() async {
    if (!formKey.currentState!.validate()) return null;
    isLoading.value = true;
    try {
      var response = await authenticationService.login(
          emailController.text, passwordController.text);
      if (response.succeeded) {
        tokenService.writeToken(response.token, response.refreshToken);
        Get.to(HomePage());
      } else {
        Get.snackbar(
            "error", response.errors.map((e) => e.enError).toList().join('\n'));
      }
    } finally {
      isLoading.value = false;
    }
  }
}
