import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FirebaseDb extends GetxController {
  final _database = FirebaseDatabase.instance.ref();
  List<dynamic> rewards = List.empty(growable: true);

  late StreamSubscription<DatabaseEvent> rewardsStreamSubscription;
  late Stream<DatabaseEvent> stream;
  int rewardsCounter = 0;

  void onDeleteReward(int index) {
    List<dynamic> newRewards = rewards;

    newRewards.removeAt(index);

    _database.update({'rewards': newRewards});
  }

  void onAddReward({
    required String name,
    required String value,
    required String amount,
    required String desc,
  }) {
    List<dynamic> newRewards = [];

    newRewards.assignAll(rewards);
    newRewards.insert(
      1,
      {
        'name': name,
        'value': value,
        'amount': amount,
        'desc': desc,
        'isClaimed': 1
      },
    );

    _database.update({'rewards': newRewards});
  }

  void onGetReward(
      {required String name,
      required String value,
      required String amount,
      required String desc,
      String claimer = 'Sakhe',
      required int index}) {
    List<dynamic> newRewards = [];

    newRewards.assignAll(rewards);
    newRewards.insert(
      index,
      {
        'name': name,
        'value': value,
        'amount': amount,
        'desc': desc,
        'isClaimed': 1,
        'claimer': claimer
      },
    );

    _database.update({'rewards': newRewards});
  }

  @override
  void onInit() {
    stream = _database.child('rewards').onValue.asBroadcastStream();

    rewardsStreamSubscription = _database.child('rewards').onValue.listen(
      (event) {
        rewards = event.snapshot.value as List;
        rewardsCounter = rewards.length;
      },
    );
    super.onInit();
  }

  @override
  void onClose() {
    rewardsStreamSubscription.cancel();
    super.onClose();
  }
}
