import 'package:get/get.dart';
import 'package:west_sea/app/services/local_db.dart';
import '../controllers/home_controller.dart';

class HomeBinding implements Bindings {
  LocalDbService localDbService = LocalDbService();
  @override
  void dependencies() {
    Get.putAsync(() => localDbService.init());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
