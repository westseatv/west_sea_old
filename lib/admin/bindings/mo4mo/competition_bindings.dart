import 'package:get/get.dart';
import 'package:west_sea/admin/controllers/mo4mo/competition_ctrl.dart';

class AdminCompetitionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CompetitionController());
  }
}
