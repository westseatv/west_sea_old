import 'package:get/get.dart';

import '../controllers/auth_ctrl.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAuthController>(() => AdminAuthController());
  }
}
