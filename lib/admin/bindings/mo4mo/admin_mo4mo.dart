import 'package:get/get.dart';
import 'package:west_sea/services/mo4mo/mo4mo_data.dart';

import '../../controllers/mo4mo/mo4mo_ctrl.dart';

class AdminMom4moBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(Mo4moFirebase());
    Get.put(AdminMo4moController());
  }
}
