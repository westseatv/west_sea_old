import 'package:get/get.dart';
import 'package:west_sea/app/controllers/lunchtime_ctrl.dart';
import 'package:west_sea/app/controllers/teatime_ctrl.dart';
import '../controllers/predictionsdart_controller.dart';

class PredictionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PredictionsControler>(() => PredictionsControler());
  }
}

class LunchtimeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LunchtimeController>(LunchtimeController());
  }
}

class TeatimeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TeatimController>(TeatimController());
  }
}
