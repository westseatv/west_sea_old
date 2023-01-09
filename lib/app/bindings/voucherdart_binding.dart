
import 'package:get/get.dart';
import '../controllers/voucherdart_controller.dart';


class VoucherDartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherDartController>(() => VoucherDartController());
  }
}