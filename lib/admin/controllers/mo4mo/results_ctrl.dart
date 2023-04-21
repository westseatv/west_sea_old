import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:west_sea/common/utils/date.dart';
import 'package:west_sea/common/utils/toast.dart';

const competitionPath = 'mo4mo/competition';
const resultsPath = 'results';

class AdminResultsController extends GetxController {
  final dbRef = FirebaseDatabase.instance.ref(competitionPath);
  late Stream<DatabaseEvent> resultsStream;
  late StreamSubscription<DatabaseEvent> resultsSubcription;
  late List<dynamic> results;

  List<String> genetedResults = List.generate(7, (index) => '${index + 1}');
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
        'results': genetedResults,
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
    super.onInit();
  }
}
