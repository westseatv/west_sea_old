import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/data/dice_firebase.dart';

class AdminDiceController extends GetxController {
  final nameTxtCtrl = TextEditingController();
  final valueTxtCtrl = TextEditingController();
  final amountTxtCtrl = TextEditingController();
  final descTxtCtrl = TextEditingController();
  final firebaseDb = Get.put(DiceFirebaseDb());

  @override
  void onClose() {
    nameTxtCtrl.dispose();
    valueTxtCtrl.dispose();
    amountTxtCtrl.dispose();
    descTxtCtrl.dispose();
    firebaseDb.dispose();
    super.onClose();
  }
}
