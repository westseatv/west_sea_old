import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseDb extends GetxController {
  final dbRef = FirebaseDatabase.instance.ref();
  late Stream<DatabaseEvent> predictionsStream;

  late StreamSubscription<DatabaseEvent> lunchtimeTwoBallPredictionsSubcription;
  late StreamSubscription<DatabaseEvent>
      lunchtimeThreeBallPredictionsSubcription;
  late StreamSubscription<DatabaseEvent> lunchtimeBonusesPredictionsSubcription;
  late StreamSubscription<DatabaseEvent> teatimeTwoBallPredictionsSubcription;
  late StreamSubscription<DatabaseEvent> teatimeThreeBallPredictionsSubcription;
  late StreamSubscription<DatabaseEvent> teatimeBonusesPredictionsSubcription;

  late List<dynamic> lunchtimeTwoBallPredictions;
  late List<dynamic> lunchtimeThreeBallPredictions;
  late List<dynamic> lunchtimeBonusesPredictions;
  late List<dynamic> teatimeTwoBallPredictions;
  late List<dynamic> teatimeThreeBallPredictions;
  late List<dynamic> teatimeBonusesPredictions;

  void onAddPrediction(
      {required String b,
      required List<String> balls,
      required String date,
      required String whichOne}) {
    List<dynamic> newList = [];
    if (whichOne == 'lunchtime') {
      switch (b) {
        case '2':
          newList.assignAll(lunchtimeTwoBallPredictions);
          newList.add({'balls': balls, 'date': date});
          dbRef.child('predictions/lunchtime/').update({'2ball': newList});
          break;
        case '3':
          newList.assignAll(lunchtimeThreeBallPredictions);
          newList.add({'balls': balls, 'date': date});
          dbRef.child('predictions/lunchtime/').update({'3ball': newList});
          break;
        case 'b':
          newList.assignAll(lunchtimeBonusesPredictions);
          newList.add({'ball': balls[0], 'date': date});
          dbRef.child('predictions/lunchtime/').update({'bonuses': newList});
          break;
        default:
          Get.showSnackbar(
            const GetSnackBar(
              duration: Duration(seconds: 5),
              message: 'Invalid ball',
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP,
            ),
          );
          break;
      }
    } else {
      switch (b) {
        case '2':
          newList.assignAll(teatimeTwoBallPredictions);
          newList.add({'balls': balls, 'date': date});
          dbRef.child('predictions/teatime/').update({'2ball': newList});
          break;
        case '3':
          newList.assignAll(teatimeThreeBallPredictions);
          newList.add({'balls': balls, 'date': date});
          dbRef.child('predictions/teatime/').update({'3ball': newList});
          break;
        case 'b':
          newList.assignAll(teatimeBonusesPredictions);
          newList.add({'ball': balls[0], 'date': date});
          dbRef.child('predictions/teatime/').update({'bonuses': newList});
          break;
        default:
          Get.showSnackbar(
            const GetSnackBar(
              duration: Duration(seconds: 5),
              message: 'Invalid ball',
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP,
            ),
          );
          break;
      }
    }
  }

  void clear(String b, String whichOne) {
    List<dynamic> newList2 = [];
    List<dynamic> newList3 = [];
    List<dynamic> newListb = [];

    if (whichOne == 'lunchtime') {
      switch (b) {
        case '2':
          newList2.add(lunchtimeTwoBallPredictions[0]);
          dbRef.child('predictions/lunchtime/').update({'2ball': newList2});
          break;
        case '3':
          newList3.add(lunchtimeThreeBallPredictions[0]);
          dbRef.child('predictions/lunchtime/').update({'3ball': newList3});
          break;
        case 'b':
          newListb.add(lunchtimeBonusesPredictions[0]);
          dbRef.child('predictions/lunchtime/').update({'bonuses': newListb});
          break;
        case 'all':
          newList2.add(lunchtimeTwoBallPredictions[0]);
          newList3.add(lunchtimeTwoBallPredictions[0]);
          newListb.add(lunchtimeBonusesPredictions[0]);
          dbRef.child('predictions/lunchtime/').update({'2ball': newList2});
          dbRef.child('predictions/lunchtime/').update({'3ball': newList3});
          dbRef.child('predictions/lunchtime/').update({'bonuses': newListb});
          break;
        default:
      }
    } else {
      switch (b) {
        case '2':
          newList2.add(teatimeTwoBallPredictions[0]);
          dbRef.child('predictions/teatime/').update({'2ball': newList2});
          break;
        case '3':
          newList3.add(teatimeThreeBallPredictions[0]);
          dbRef.child('predictions/teatime/').update({'3ball': newList3});
          break;
        case 'b':
          newListb.add(teatimeBonusesPredictions[0]);
          dbRef.child('predictions/teatime/').update({'bonuses': newListb});
          break;
        case 'all':
          newList2.add(teatimeTwoBallPredictions[0]);
          newList3.add(teatimeTwoBallPredictions[0]);
          newListb.add(teatimeBonusesPredictions[0]);
          dbRef.child('predictions/teatime/').update({'2ball': newList2});
          dbRef.child('predictions/teatime/').update({'3ball': newList3});
          dbRef.child('predictions/teatime/').update({'bonuses': newListb});
          break;
        default:
      }
    }
  }

  @override
  void onInit() {
    predictionsStream = dbRef.child('predictions').onValue.asBroadcastStream();

    lunchtimeTwoBallPredictionsSubcription =
        dbRef.child('predictions/lunchtime/2ball').onValue.listen(
      (event) {
        lunchtimeTwoBallPredictions = event.snapshot.value as List;
      },
    );
    lunchtimeThreeBallPredictionsSubcription =
        dbRef.child('predictions/lunchtime/3ball').onValue.listen(
      (event) {
        lunchtimeThreeBallPredictions = event.snapshot.value as List;
      },
    );
    lunchtimeBonusesPredictionsSubcription =
        dbRef.child('predictions/lunchtime/bonuses').onValue.listen(
      (event) {
        lunchtimeBonusesPredictions = event.snapshot.value as List;
      },
    );

    teatimeTwoBallPredictionsSubcription =
        dbRef.child('predictions/teatime/2ball').onValue.listen(
      (event) {
        teatimeTwoBallPredictions = event.snapshot.value as List;
      },
    );
    teatimeThreeBallPredictionsSubcription =
        dbRef.child('predictions/teatime/3ball').onValue.listen(
      (event) {
        teatimeThreeBallPredictions = event.snapshot.value as List;
      },
    );
    teatimeBonusesPredictionsSubcription =
        dbRef.child('predictions/teatime/bonuses').onValue.listen(
      (event) {
        teatimeBonusesPredictions = event.snapshot.value as List;
      },
    );

    super.onInit();
  }

  @override
  void onClose() {
    lunchtimeTwoBallPredictionsSubcription.cancel();
    lunchtimeThreeBallPredictionsSubcription.cancel();
    lunchtimeBonusesPredictionsSubcription.cancel();

    teatimeTwoBallPredictionsSubcription.cancel();
    teatimeThreeBallPredictionsSubcription.cancel();
    teatimeBonusesPredictionsSubcription.cancel();
    super.onClose();
  }
}
