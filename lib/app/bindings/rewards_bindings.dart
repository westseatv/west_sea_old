import 'package:get/get.dart';
import 'package:west_sea/app/controllers/rewards_controller.dart';

class RewardsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RewardsController());
  }
}
