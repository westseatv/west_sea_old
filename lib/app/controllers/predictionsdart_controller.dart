import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea/app/controllers/home_controller.dart';
import 'package:west_sea/services/data/firebase.dart';

class PredictionsControler extends GetxController {
  final firebaseDb = Get.put(FirebaseDb());
  final homeCtrl = Get.put(HomeController());
  int index = 0;
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
    homeCtrl.dispose();
    super.onClose();
  }
}
