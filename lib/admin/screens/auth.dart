import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea/admin/routes/names.dart';

import '../controllers/auth_ctrl.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: controller.txtCtrl,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  readOnly: controller.attempts.value == 0,
                  decoration: const InputDecoration(
                    label: Text('What??'),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: controller.attempts.value > 0
                      ? () {
                          if (controller.txtCtrl.text == '') {
                            controller.txtCtrl.clear();
                            Get.offAllNamed(AdminRoutes.home);
                          } else {
                            controller.txtCtrl.clear();
                            controller.attempts(controller.attempts.value - 1);
                          }
                        }
                      : null,
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 50,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
