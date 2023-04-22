import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../../common/models/competion.dart';

class AdminMo4moController extends GetxController {
  final dbRef = FirebaseDatabase.instance.ref('mo4mo');
  List<dynamic> recents = [];
  late CompetitionModel competition;

  void onAdd({required CompetitionModel competitionModel}) async {
    if (recents.length == 6) {
      recents.removeAt(1);
      recents.add(
        {
          'name': competitionModel.name,
          'prize': competitionModel.prize,
          'prizes': competitionModel.prizes,
          'endDate': competitionModel.endDate,
        },
      );
    } else {
      recents.add(
        {
          'name': competitionModel.name,
          'prize': competitionModel.prize,
          'prizes': competitionModel.prizes,
          'endDate': competitionModel.endDate,
        },
      );
    }

    dbRef.update(
      {
        'competition': competitionModel.toMap(),
        'recents': recents,
      },
    );

    await dbRef.child('recents').get().then(
      (event) {
        recents = event.value as List;
      },
    );

    await dbRef.child('competition').get().then(
      (event) {
        var data = event.value;
        competition = CompetitionModel.fromMap(data as Map<String, dynamic>);
      },
    );
    //refresh();
  }

  void onEnd() async {
    await dbRef.child('competition').get().then(
      (event) {
        var data = event.value;
        competition = CompetitionModel.fromMap(data as Map<String, dynamic>);
        competition.status = 'ENDED';
      },
    );

    await dbRef.update(
      {
        'competition': competition.toMap(),
      },
    );
  }

  @override
  void onInit() {
    dbRef.child('competition').get().then(
      (event) {
        var data = event.value;
        competition = CompetitionModel.fromMap(data as Map<String, dynamic>);
      },
    );
    dbRef.child('recents').get().then((event) {
      recents = event.value as List;
    });
    super.onInit();
  }
}
