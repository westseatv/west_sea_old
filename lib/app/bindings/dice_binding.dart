import 'package:get/get.dart';
import 'package:west_sea/app/controllers/dice_controller.dart';

class AppDiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppDiceController());
  }
}
