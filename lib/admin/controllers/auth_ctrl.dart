import 'package:get/get.dart';
import 'package:west_sea/admin/screens/home/admin_home_page.dart';

class AdminAuthController extends GetxController {
  List<String> securedTextList = [];
  var securedText = ''.obs;
  List<String> enterdedPin = [];
  String pin = '8475';
  var attempts = 3.obs;
  var status = ''.obs;

  void numberTapped(String n) {
    if (attempts.value > 0) {
      String s = '';
      enterdedPin.add(n);
      securedTextList.add('*');
      for (var element in securedTextList) {
        s = s + element;
      }
      securedText(s);
      status('');
    }
  }

  void onCancel() {
    if (securedTextList.isNotEmpty && enterdedPin.isNotEmpty) {
      String s = '';
      securedTextList.removeLast();
      for (var element in securedTextList) {
        s = s + element;
      }
      securedText(s);
      enterdedPin.removeLast();
    }
  }

  void onDone() {
    if (attempts.value > 0 && enterdedPin.isNotEmpty) {
      String p = '';
      for (var number in enterdedPin) {
        p = p + number;
      }
      if (pin == p) {
        securedTextList = [];
        enterdedPin = [];
        securedText('');
        Get.offAll(
          () => const AdminHomePage(),
        );
      } else {
        securedTextList = [];
        securedText('');
        enterdedPin = [];
        attempts -= 1;
        status(' Wrong pin');
      }
    }
    if (attempts.value < 1) {
      status('');
      securedText('BLOCKED');
      securedTextList = [];
      enterdedPin = [];
    }
  }
}
