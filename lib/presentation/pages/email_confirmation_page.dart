import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/email_confirmation_controller.dart';

class EmailConfirmationPage extends StatelessWidget {
  EmailConfirmationPage({Key? key}) : super(key: key);

  final EmailConfirmationController controller =
      Get.put(EmailConfirmationController(Get.arguments));

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                    controller: controller.codeController,
                    decoration: const InputDecoration(
                      labelText: 'Code',
                      prefixIcon: Icon(Icons.code),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter the code' : null),
                const SizedBox(height: 16.0),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.confirmEmail(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      textStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      minimumSize: const Size(200, 50),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Confirm'),
                  ),
                ),
                const SizedBox(height: 16.0),
                Obx(
                  () => GestureDetector(
                    onTap: () =>
                        controller.canResend.value ? controller.resend() : null,
                    child: Text(
                      controller.canResend.value ? 'Resend Code' : 'Wait ${controller.secondsRemaining.value} seconds.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
