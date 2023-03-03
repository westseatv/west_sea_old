import 'package:get/get.dart';

import '../controllers/teatime.dart';

class AdminTeatimeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AdminTeatimeController>(AdminTeatimeController());
  }
}
