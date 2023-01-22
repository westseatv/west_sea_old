import 'package:get/get.dart';
import 'package:west_sea/admin/controllers/vouchers_ctrl.dart';

class AdminVouchersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VouchersController>(() => VouchersController());
  }
}
