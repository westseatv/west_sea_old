import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logo extends StatelessWidget {
  final double? h;
  final double? w;
  const Logo({
    Key? key,
    this.h,
    this.w,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h ?? Get.height * 0.20,
      width: w,
      child: Image.asset('assets/mo4mo.png'),
    );
  }
}
