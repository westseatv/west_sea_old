// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocalDbService extends GetxService {
//   late final SharedPreferences _prefs;
//   Future<LocalDbService> init() async {
//     _prefs = await SharedPreferences.getInstance();
//     coinAmount();
//     diamondAmount();
//     return this;
//   }

//   Future<bool> setString(String key, String value) async {
//     return await _prefs.setString(key, value);
//   }

//   Future<bool> setInt(String key, int value) async {
//     return await _prefs.setInt(key, value);
//   }

//   String getString(String key) {
//     return _prefs.getString(key) ?? '';
//   }

//   int getInt(String key) {
//     return _prefs.getInt(key) ?? -1;
//   }

//   void incrementCoins(int value) async {
//     int coins = getInt('coins');
//     await setInt('coins', coins + value);
//   }

//   void decrementCoins(int value) async {
//     int coins = getInt('coins');
//     await setInt('coins', coins - value);
//   }

//   void incrementDiamonds(int value) async {
//     int diamonds = getInt('diamonds');
//     await setInt('diamonds', diamonds + value);
//   }

//   void dencrementDiamonds(int value) async {
//     int diamonds = getInt('diamonds');
//     await setInt('diamonds', diamonds - value);
//   }

//   Future<bool> reset() async {
//     return await _prefs.clear();
//   }

//   int coinAmount() {
//     int coins = getInt('coins');
//     if (coins == -1) {
//       setInt('coins', 5).then((value) => coins = getInt('coins'));
//     }

//     return coins;
//   }

//   int diamondAmount() {
//     int diamonds = getInt('diamonds');
//     if (diamonds == -1) {
//       setInt('diamonds', 0).then((value) => diamonds = getInt('diamonds'));
//     }

//     return diamonds;
//   }

//   @override
//   void onInit() async {
//     await init();
//     coinAmount();
//     diamondAmount();
//     super.onInit();
//   }
// }
