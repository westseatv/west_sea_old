import 'package:get/get.dart';
import 'package:west_sea/app/controllers/dice_controller.dart';
import 'package:west_sea/app/services/local_db.dart';
import 'package:west_sea/services/data/dice_firebase.dart';

class RewardsController extends GetxController {
  final DiceFirebaseDb diceFirebaseDb = Get.put(DiceFirebaseDb());
  final LocalDbService localDbService = Get.find<LocalDbService>();
  final AppDiceController appDiceController = Get.find<AppDiceController>();

  @override
  void onClose() {
    diceFirebaseDb.dispose();
    super.onClose();
  }
}
