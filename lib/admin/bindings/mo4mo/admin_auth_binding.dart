import 'package:get/get.dart';
import 'package:west_sea/admin/controllers/auth_ctrl.dart';

class AdminAuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AdminAuthController());
  }
}
