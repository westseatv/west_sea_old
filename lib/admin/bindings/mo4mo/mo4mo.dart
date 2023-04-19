import 'package:get/get.dart';

import '../../controllers/mo4mo/mo4mo_ctrl.dart';

class AdminMom4moBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AdminMo4moController());
  }
}
