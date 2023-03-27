import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/data/services/authentication_service.dart';
import 'package:hamrin_app/data/services/token_service.dart';
import 'package:hamrin_app/presentation/routes/app_routes.dart';

class EmailConfirmationController extends GetxController {
  final String email;
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthenticationService _authenticationService = AuthenticationService();
  final TokenService _tokenService = TokenService();
  var isLoading = false.obs;
  Timer? _timer;
  var secondsRemaining = 60.obs;
  var canResend = false.obs;

  EmailConfirmationController(this.email);

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    _timer?.cancel();
    canResend.value = false;
    secondsRemaining.value = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value == 0) {
        timer.cancel();
        canResend.value = true;
      } else {
        secondsRemaining.value--;
      }
    });
  }

  confirmEmail() async {
    if (!formKey.currentState!.validate()) return null;
    isLoading.value = true;
    try {
      var response =
          await _authenticationService.confirmEmail(email, codeController.text);
      if (response.succeeded) {
        await _tokenService.writeToken(response.token, response.refreshToken);
        Get.offNamed(AppRoutes.home);
      } else {
        Get.snackbar(
            "error", response.errors.map((e) => e.enError).toList().join('\n'));
      }
    } finally {
      isLoading.value = false;
    }
  }

  resend() async {
    startTimer();
    await _authenticationService.resendEmail(email);
  }
}
