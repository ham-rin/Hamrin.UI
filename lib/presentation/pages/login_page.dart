import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamrin_app/presentation/controllers/login_controller.dart';
import 'package:hamrin_app/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
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
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty
                      ? 'Please enter your email'
                      : GetUtils.isEmail(value)
                          ? null
                          : 'Please enter a valid email address',
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your password' : null,
                ),
                const SizedBox(height: 16.0),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.login(),
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
                        : const Text('Login'),
                  ),
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    Get.to(() => HomePage());
                  },
                  child: Text(
                    'Don\'t have an account? Sign up',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
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
