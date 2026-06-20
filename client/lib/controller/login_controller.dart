import 'dart:math';
import 'package:client/model/user/user_model.dart';
import 'package:client/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_text_field_v2.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;
  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerNumberCtrl = TextEditingController();
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  TextEditingController loginNumberCtrl = TextEditingController();
  bool otpFieldShow = false;
  int? otpSend;
  int? otpEntered;
  UserModel? loginUser;

  @override
  void onReady() {
    Map<String, dynamic>? user = box.read('LoginUser');
    if (user != null) {
      loginUser = UserModel.fromJson(user);
      Get.to(HomePage());
    } else {}
    super.onReady();
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  @override
  void onClose() {
    registerNameCtrl.dispose();
    registerNumberCtrl.dispose();
    loginNumberCtrl.dispose();
    super.onClose();
  }

  addUser() async {
    try {
      if (otpSend == otpEntered) {
        DocumentReference doc = userCollection.doc();
        UserModel user = UserModel(
          id: doc.id,
          name: registerNameCtrl.text,
          number: int.parse(registerNumberCtrl.text),
        );
        final userJson = user.toJson();
        await doc.set(userJson);

        // Update loginUser with the newly registered user
        loginUser = user;
        box.write('LoginUser', userJson);

        Get.snackbar(
          'Success',
          'User added successfully',
          colorText: Colors.green,
        );
        registerNameCtrl.clear();
        registerNumberCtrl.clear();
        otpController.clear();
        otpFieldShow = false;

        // Auto-login the new user
        Get.offAll(() => HomePage());
      } else {
        Get.snackbar('Error', 'OTP is incorrect', colorText: Colors.red);
      }
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  sendOtp() {
    try {
      if (registerNameCtrl.text.isEmpty || registerNumberCtrl.text.isEmpty) {
        Get.snackbar('Error', 'Please fill the field', colorText: Colors.red);
        return;
      }

      final random = Random();
      int otp = 1000 + random.nextInt(9000);
      Get.snackbar('Success', 'Your otp is $otp', colorText: Colors.green);
      otpFieldShow = true;
      otpSend = otp;
    } finally {
      update();
    }
  }

  Future<void> loginWithPhone() async {
    String phoneNumber = loginNumberCtrl.text;
    if (phoneNumber.isNotEmpty) {
      var querySnapshot = await userCollection
          .where('number', isEqualTo: int.tryParse(phoneNumber))
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        var userData = userDoc.data() as Map<String, dynamic>;

        loginUser = UserModel.fromJson(userData);

        box.write('LoginUser', userData);

        loginNumberCtrl.clear();

        update(); // Notify UI of state change

        Get.offAll(() => HomePage());

        Get.snackbar('Success', 'Login successful', colorText: Colors.green);
      }
    } else {
      Get.snackbar(
        'Error',
        'Please enter a phone number',
        colorText: Colors.red,
      );
    }
  }
}
