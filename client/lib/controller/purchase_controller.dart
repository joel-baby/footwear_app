import 'package:client/controller/login_controller.dart';
import 'package:client/model/user/user_model.dart';
import 'package:client/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PurchaseController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;

  double orderPrice = 0;
  String itemName = '';
  String orderAddress = '';

  TextEditingController addressController = TextEditingController();

  @override
  void onInit() {
    orderCollection = firestore.collection('orders');
    super.onInit();
  }

  @override
  void onClose() {
    addressController.dispose();
    super.onClose();
  }

  submitOrder({
    required double price,
    required String item,
    required String description,
  }) {
    orderPrice = price;
    itemName = item;
    orderAddress = addressController.text;

    Razorpay _razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_T360dT9pyMZXhb',
      'amount': price * 100,
      'currency': 'INR',
      'name': item,
      'description': description,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    };
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.open(options);
  }

  Future<void> orderSuccess({required String? transactionId}) async {
    UserModel? loginUse = Get.find<LoginController>().loginUser;
    try {
      if (transactionId != null) {
        DocumentReference docRef = await orderCollection.add({
          'customer': loginUse?.name ?? '',
          'phone': loginUse?.number ?? '',
          'item': itemName,
          'price': orderPrice,
          'address': orderAddress,
          'transactionId': transactionId,
          'dateTime': DateTime.now().toString(),
        });
        showOrderSuccessDailog(docRef.id);
        Get.snackbar(
          'Success',
          'Order Created Successfully',
          colorText: Colors.green,
        );
      } else {
        Get.snackbar(
          'Error',
          'Please fill all the fields',
          colorText: Colors.red,
        );
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to create order', colorText: Colors.red);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    orderSuccess(transactionId: response.paymentId);
    Get.snackbar('Success', 'Payment is successfull', colorText: Colors.green);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar('Error', '${response.message}', colorText: Colors.red);
  }

  void showOrderSuccessDailog(String orderId) {
    Get.defaultDialog(
      title: 'Order Successful',
      content: Text('Your order Id is $orderId'),
      confirm: ElevatedButton(
        onPressed: () {
          Get.offAll(HomePage());
        },
        child: Text('Close'),
      ),
    );
  }
}
