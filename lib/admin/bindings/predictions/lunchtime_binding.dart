import 'package:get/get.dart';

import '../../controllers/predictions/lunchtime.dart';

class AdminLunchtimeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AdminLunchtimeController>(AdminLunchtimeController());
  }
}
