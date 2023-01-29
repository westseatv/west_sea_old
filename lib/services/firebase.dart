import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseDb extends GetxController {
  final dbRef = FirebaseDatabase.instance.ref();
  late Stream<DatabaseEvent> voucherStream;
  late Stream<DatabaseEvent> predictionsStream;
  late StreamSubscription<DatabaseEvent> vouchersSubcription;
  late StreamSubscription<DatabaseEvent> twoBallPredictionsSubcription;
  late StreamSubscription<DatabaseEvent> threeBallPredictionsSubcription;
  late List<dynamic> vouchers;
  late List<dynamic> twoBallPredictions;
  late List<dynamic> threeBallPredictions;

  void onDeleteVouchers({
    required int index,
  }) {
    List<dynamic> newVouchers = [];
    for (var v in vouchers) {
      if (v != vouchers[index]) {
        newVouchers.add(v);
      }
    }
    dbRef.child('vouchers/').update({'list': newVouchers});
  }

  void onAddVoucher({required String v, required String f, required String c}) {
    List<dynamic> newList = [];

    newList.assignAll(vouchers);

    newList.add({'v': v, 'f': f, 'c': c, 't': 1});
    dbRef.child('vouchers/').update({'list': newList});
  }

  void claiming(int index) {
    dbRef.child('vouchers/list/$index/').update({'t': 0});
  }

  void onAddPrediction(
      {required String b, required List<String> balls, required String date}) {
    List<dynamic> newList = [];
    switch (b) {
      case '2':
        newList.assignAll(twoBallPredictions);
        newList.add({'balls': balls, 'date': date});
        dbRef.child('vouchers/predictions/').update({'2ball': newList});
        break;
      case '3':
        newList.assignAll(threeBallPredictions);
        newList.add({'balls': balls, 'date': date});
        dbRef.child('vouchers/predictions/').update({'3ball': newList});
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

  void clear(String b) {
    List<dynamic> newList = [];
    switch (b) {
      case '2':
        newList.add(twoBallPredictions[0]);
        dbRef.child('vouchers/predictions/').update({'2ball': newList});
        break;
      case '3':
        newList.add(threeBallPredictions[0]);
        dbRef.child('vouchers/predictions/').update({'3ball': newList});
        break;
      case 'all':
        newList.add(twoBallPredictions[0]);
        dbRef.child('vouchers/predictions/').update({'2ball': newList});
        dbRef.child('vouchers/predictions/').update({'3ball': newList});
        break;
      default:
    }
  }

  @override
  void onInit() {
    voucherStream = dbRef.child('vouchers/list').onValue.asBroadcastStream();
    vouchersSubcription = dbRef.child('vouchers/list').onValue.listen(
      (event) {
        vouchers = event.snapshot.value as List;
      },
    );

    predictionsStream =
        dbRef.child('vouchers/predictions').onValue.asBroadcastStream();
    twoBallPredictionsSubcription =
        dbRef.child('vouchers/predictions/2ball').onValue.listen(
      (event) {
        twoBallPredictions = event.snapshot.value as List;
      },
    );
    threeBallPredictionsSubcription =
        dbRef.child('vouchers/predictions/3ball').onValue.listen(
      (event) {
        threeBallPredictions = event.snapshot.value as List;
      },
    );

    super.onInit();
  }

  @override
  void onClose() {
    vouchersSubcription.cancel();
    twoBallPredictionsSubcription.cancel();
    threeBallPredictionsSubcription.cancel();
    super.onClose();
  }
}
