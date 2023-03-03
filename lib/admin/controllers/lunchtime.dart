import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/data/firebase.dart';

class AdminLunchtimeController extends GetxController {
  final firebaseDb = Get.put(FirebaseDb());
  final b1TxtCtrl = TextEditingController();
  final b2TxtCtrl = TextEditingController();
  final b3TxtCtrl = TextEditingController();
  final b = TextEditingController();
  var ball = '0'.obs;

  List<Color> colors(int l, int b) {
    int length = b * l;

    return List.generate(
      length,
      (index) {
        int r = Random(121 + (index + 1) * 43).nextInt(255) + 10;
        int g = Random(10 * (index + 1) * 43).nextInt(255) + 10;
        int b = Random(25 ~/ (index + 1) * 43).nextInt(225) + 10;
        return Color.fromARGB(255, r, g, b);
      },
    );
  }

  @override
  void onClose() {
    firebaseDb.onClose();
    b1TxtCtrl.dispose();
    b2TxtCtrl.dispose();
    b3TxtCtrl.dispose();
    b.dispose();
    super.onClose();
  }
}
