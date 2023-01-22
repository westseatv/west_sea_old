import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:west_sea/services/firebase.dart';

class VouchersController extends GetxController {
  final firebaseDb = Get.put(FirebaseDb());
  final vTxtCtrl = TextEditingController();
  final fTxtCtrl = TextEditingController();
  final cTxtCtrl = TextEditingController();

  @override
  void onClose() {
    firebaseDb.onClose();
    vTxtCtrl.dispose();
    fTxtCtrl.dispose();
    cTxtCtrl.dispose();
    super.onClose();
  }
}
