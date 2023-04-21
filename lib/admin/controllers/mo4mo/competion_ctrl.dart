import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:west_sea/common/models/competion.dart';

class AdminCompetitionController extends GetxController {
  final dbRef = FirebaseDatabase.instance.ref('mo4mo');
  List<dynamic> recents = [];
  late CompetionModel competition;

  void onAdd({required CompetionModel competionModel}) {
    dbRef.child('recents').get().then(
      (event) {
        recents = event.value as List;
      },
    );
    dbRef.update(
      {
        'competition': competionModel.toMap(),
        'recents': recents,
      },
    );
  }

  void onEnd() async {
    await dbRef.child('competitions').get().then(
      (event) {
        var data = event.value;
        competition = CompetionModel.fromMap(data as Map<String, dynamic>);
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
    dbRef.child('competitions').get().then(
      (event) {
        var data = event.value;
        competition = CompetionModel.fromMap(data as Map<String, dynamic>);
      },
    );
    super.onInit();
  }
}
