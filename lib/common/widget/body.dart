import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/pallete.dart';
import 'logo.dart';

class Body extends StatelessWidget {
  final Widget child;
  const Body({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Logo(),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          color: Pallete.grayshColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        child: child,
      ),
    );
  }
}
