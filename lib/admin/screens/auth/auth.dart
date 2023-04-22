// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import 'package:west_sea/common/theme/pallete.dart';

import '../../../common/widget/logo.dart';
import '../../controllers/auth_ctrl.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Logo(),
              Obx(
                () => Text('Left attempts: ${controller.attempts.value}'),
              ),
              Obx(
                () => Text(controller.status.value),
              ),
              pinField(),
              StaggeredGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  number('7'),
                  number('8'),
                  number('9'),
                  number('4'),
                  number('5'),
                  number('6'),
                  number('1'),
                  number('2'),
                  number('3'),
                  number('0'),
                  btn(isDone: false),
                  btn(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pinField() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Pallete.grayshColor.withOpacity(0.3),
      ),
      child: Obx(
        () => Text(
          controller.securedText.value,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  InkWell btn({bool isDone = true}) {
    return InkWell(
      onTap: () => isDone ? controller.onDone() : controller.onCancel(),
      child: Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Pallete.grayshColor.withOpacity(0.4),
        ),
        child: Icon(
          isDone ? Icons.done : Icons.cancel_presentation,
          size: 40,
        ),
      ),
    );
  }

  InkWell number(String n) {
    return InkWell(
      onTap: () => controller.numberTapped(n),
      child: Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Pallete.grayshColor.withOpacity(0.4),
        ),
        child: Text(
          n,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
