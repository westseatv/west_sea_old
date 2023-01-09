import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PredictionsControler extends GetxController {
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
  void onInit() {
    super.onInit();
  }
}
