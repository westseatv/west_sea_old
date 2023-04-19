import 'package:get/get.dart';

import '../../controllers/predictions/teatime.dart';

class AdminTeatimeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AdminTeatimeController>(AdminTeatimeController());
  }
}
