import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:west_sea/services/models/reward.dart';

const reward = 'rewards';

class DiceFirebaseDb extends GetxController {
  final _database = FirebaseDatabase.instance.ref();
  List<dynamic> rewards = List.empty(growable: true);

  late StreamSubscription<DatabaseEvent> rewardsStreamSubscription;
  late Stream<DatabaseEvent> stream;
  late int rewardsCounter;

  void onDeleteReward(int index) {
    List<dynamic> newRewards = rewards;

    newRewards.removeAt(index);

    _database.update({reward: newRewards});
  }

  void onAddReward({
    required String name,
    required String value,
    required int cost,
    required String desc,
  }) {
    List<dynamic> newRewards = [];
    RewardModel newReward = RewardModel(
        name: name, cost: cost, isClaimed: 1, desc: desc, value: value);

    newRewards.assignAll(rewards);
    newRewards.insert(
      1,
      newReward.toMap(),
    );

    _database.update({reward: newRewards});
  }

  void onGetReward({
    required String name,
    required String value,
    required int cost,
    required String desc,
    required int index,
  }) {
    List<dynamic> newRewards = [];
    RewardModel newReward = RewardModel(
        name: name, cost: cost, isClaimed: 0, value: value, desc: desc);
    newRewards.assignAll(rewards);
    newRewards[index] = newReward.toMap();

    _database.update({reward: newRewards});
  }

  @override
  void onInit() {
    stream = _database.child(reward).onValue.asBroadcastStream();

    rewardsStreamSubscription = _database.child(reward).onValue.listen(
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
