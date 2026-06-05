import 'dart:math';
import 'package:client/model/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field_v2/otp_text_field_v2.dart';

class LoginController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;
  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerNumberCtrl = TextEditingController();
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  bool otpFieldShow = false;
  int? otpSend;
  int? otpEntered;

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
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
        Get.snackbar(
          'Success',
          'User added successfully',
          colorText: Colors.green,
        );
        registerNameCtrl.clear();
        registerNumberCtrl.clear();
        otpController.clear();
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
      print(otp);
      Get.snackbar('Success', 'OTP send success', colorText: Colors.green);
      otpFieldShow = true;
      otpSend = otp;
    } on Exception catch (e) {
      print(e);
    } finally {
      update();
    }
  }
}
