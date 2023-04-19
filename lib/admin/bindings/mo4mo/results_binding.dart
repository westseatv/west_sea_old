import 'package:get/get.dart';
import 'package:west_sea/admin/controllers/mo4mo/results_ctrl.dart';

class AdminResultsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AdminResultsController());
  }
}
