import 'package:client/controller/login_controller.dart';
import 'package:client/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (ctrl) {
        return Scaffold(
          body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.blueGrey[50]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: ctrl.loginNumberCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.phone_android),
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ctrl.loginWithPhone();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(RegisterPage());
                  },
                  child: Text('Register new account ?'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
