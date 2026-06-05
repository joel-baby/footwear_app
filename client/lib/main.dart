import 'package:client/controller/login_controller.dart';
import 'package:client/firebase_options.dart' show firebaseOptions;
import 'package:client/pages/home_page.dart';
import 'package:client/pages/login_page.dart';
import 'package:client/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(options: firebaseOptions);
  print("Firebase Connected: ${app.name}");
  Get.put(LoginController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}
