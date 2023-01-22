import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController txtCtrl = TextEditingController();
  var attempts = 3.obs;
  @override
  void onClose() {
    txtCtrl.dispose();
    super.onClose();
  }
}
