import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

const mo4moRef = 'mo4mo';
const competition = 'competition';
const resultsRef = 'competition/results';

class Mo4moFirebase extends GetxController {
  final dbRef = FirebaseDatabase.instance.ref(mo4moRef);
  late Stream<DatabaseEvent> competitionStream;
  late Stream<DatabaseEvent> resultsStream;

  @override
  void onInit() {
    competitionStream = dbRef.onValue.asBroadcastStream();
    resultsStream = dbRef.child(resultsRef).onValue.asBroadcastStream();
    super.onInit();
  }
}
