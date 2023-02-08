import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea/services/data/firebase.dart';

import 'home_controller.dart';

class VoucherDartController extends GetxController {
  final firebaseDb = Get.put(FirebaseDb());
  final homeCtrl = Get.put(HomeController());
  final txtCtrl = TextEditingController();
  var isClaiming = false.obs;
  var claimed = false.obs;

  @override
  void onClose() {
    firebaseDb.onClose();
    txtCtrl.dispose();
    homeCtrl.dispose();
    super.onClose();
  }
}
