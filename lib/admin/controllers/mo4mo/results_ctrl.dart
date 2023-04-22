import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:west_sea/common/utils/date.dart';

const competitionPath = 'mo4mo/competition';
const resultsPath = 'results';

class AdminResultsController extends GetxController {
  final dbRef = FirebaseDatabase.instance.ref(competitionPath);
  late Stream<DatabaseEvent> resultsStream;
  late StreamSubscription<DatabaseEvent> resultsSubcription;
  late List<dynamic> results;

  RxList<String> generated = RxList.empty(growable: true);

  void generate() {
    int radNum;
    generated.assignAll(
      List.generate(
        7,
        (index) {
          radNum = Random(Timeline.now * (index + index + 1)).nextInt(49) + 1;
          while (generated.contains(radNum.toString())) {
            radNum =
                Random(Timeline.now + (index + index + 20)).nextInt(49) + 1;
          }
          return radNum.toString();
        },
      ),
    );
    update();
  }

  bool alreadyAdded(List<String> ids) {
    return ids.contains(date());
  }

  void onAddResults() async {
    List data = [];

    data.assignAll(results);

    // print(data);
    data.add(
      {
        'date': date(),
        'id': date(),
        'results': generated,
      },
    );

    dbRef.update({'results': data}).then((value) {
      navigator!.pop();
    }).onError((error, stackTrace) {
      navigator!.pop();
    });
  }

  @override
  void onInit() {
    resultsStream = dbRef.child(resultsPath).onValue;
    dbRef.child(resultsPath).onValue.listen(
      (event) {
        results = event.snapshot.value as List;
      },
    );
    generate();
    super.onInit();
  }
}
