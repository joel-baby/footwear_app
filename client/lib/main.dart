import 'package:client/controller/login_controller.dart';
import 'package:client/firebase_options.dart' show firebaseOptions;
import 'package:client/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  FlutterError.onError = (details) {
    print("Flutter Error: ${details.exception}");
    print("Stack trace: ${details.stack}");
  };

  try {
    await GetStorage.init();
    WidgetsFlutterBinding.ensureInitialized();
    
    try {
      FirebaseApp app = await Firebase.initializeApp(options: firebaseOptions);
      print("Firebase Connected: ${app.name}");
    } catch (e) {
      print("Firebase Error: $e");
      rethrow;
    }
    
    Get.put(LoginController());
    runApp(const MyApp());
  } catch (e) {
    print("Main Error: $e");
    runApp(ErrorApp(error: e.toString()));
  }
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
      home: LoginPage(),
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String error;
  const ErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Initialization Error')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Error: $error',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
