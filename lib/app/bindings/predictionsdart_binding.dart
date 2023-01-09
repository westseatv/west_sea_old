
import 'package:get/get.dart';
import '../controllers/predictionsdart_controller.dart';


class PredictionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PredictionsControler>(() => PredictionsControler());
  }
}