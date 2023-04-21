import 'package:get/get.dart';
import 'package:west_sea/admin/controllers/mo4mo/competion_ctrl.dart';

class AddCompetitionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AdminCompetitionController());
  }
}
