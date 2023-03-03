import 'package:get/get.dart';

import '../controllers/lunchtime.dart';

class AdminLunchtimeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AdminLunchtimeController>(AdminLunchtimeController());
  }
}
