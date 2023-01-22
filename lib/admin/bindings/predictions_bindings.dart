import 'package:get/get.dart';
import 'package:west_sea/admin/controllers/predictions_ctrl.dart';

class AdminPredictionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPredictionsController>(() => AdminPredictionsController());
  }
}
