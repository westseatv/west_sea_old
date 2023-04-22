import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../../common/models/competion.dart';

class AdminMo4moController extends GetxController {
  final dbRef = FirebaseDatabase.instance.ref('mo4mo');
  List<dynamic> recents = [];
  late CompetionModel competition;

  void onAdd({required CompetionModel competionModel}) async {
    if (recents.length == 6) {
      recents.removeAt(1);
      recents.add(
        {
          'name': competition.name,
          'prize': competition.prize,
          'prizes': competition.prizes,
          'endDate': competition.endDate,
        },
      );
    } else {
      recents.add(
        {
          'name': competition.name,
          'prize': competition.prize,
          'prizes': competition.prizes,
          'endDate': competition.endDate,
        },
      );
    }

    dbRef.update(
      {
        'competition': competionModel.toMap(),
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
        competition = CompetionModel.fromMap(data as Map<String, dynamic>);
      },
    );
    //refresh();
  }

  void onEnd() async {
    await dbRef.child('competition').get().then(
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
    dbRef.child('competition').get().then(
      (event) {
        var data = event.value;
        competition = CompetionModel.fromMap(data as Map<String, dynamic>);
      },
    );
    super.onInit();
  }

  Map<String, dynamic> data = {
    "updates": {
      "v100": {
        "isOutdated": false,
        "massege": "You to update this app by click on update"
      }
    },
    "competition": {
      "id": "16042023",
      "status": "ONGOING",
      "name": "Capitec Cash Sent",
      "prize": "R1000",
      "prizes": ["R500", "R300", "R200"],
      "desc": "You can withdraw it any Capitec ATM without a card",
      "stake": 50,
      "endDate": "16 April 2023",
      "results": [
        {
          "id": "12/04/2023",
          "date": "12/04/2023",
          "results": ["5", "24", "13", "17", "11", "34", "44"]
        },
        {
          "id": "13/04/2023",
          "date": "13/04/2023",
          "results": ["5", "24", "13", "17", "11", "34", "44"]
        },
        {
          "id": "14/04/2023",
          "date": "14/04/2023",
          "results": ["5", "24", "13", "17", "11", "34", "44"]
        },
        {
          "id": "15/04/2023",
          "date": "15/04/2023",
          "results": ["5", "24", "13", "17", "11", "34", "44"]
        }
      ],
      "winners": [],
      "contenders": [
        {
          "id": "tyttetrffdfsef",
          "name": "Punter1",
          "points": 27,
          "p": 4,
          "w": 3
        },
        {
          "id": "tyttetrffdfsef",
          "name": "Punter2",
          "points": 30,
          "p": 3,
          "w": 3
        },
        {
          "id": "tyttetrffdfsef",
          "name": "Punter3",
          "points": 3,
          "p": 4,
          "w": 3
        },
        {
          "id": "tyttetrffdfsef",
          "name": "Punter4",
          "points": 6,
          "p": 4,
          "w": 2
        },
        {
          "id": "tyttetrffdfsef",
          "name": "Punter6",
          "points": 15,
          "p": 9,
          "w": 3
        },
        {
          "id": "tyttetrffdfsef",
          "name": "Punter5",
          "points": 39,
          "p": 20,
          "w": 13
        },
        {
          "id": "tyttetrffdfsef",
          "name": "Punter7",
          "points": 24,
          "p": 21,
          "w": 3
        },
        {
          "id": "tyttetrffdfsef",
          "name": "Punter8",
          "points": 27,
          "p": 21,
          "w": 5
        }
      ]
    },
    "recents": [
      {
        "name": "Cash Sent",
        "prize": "R1000",
        "prizes": ["R350", "R200", "R150"],
        "winners": ["Uzzi", "Nike", "Adidas"]
      },
      {
        "name": "Cash Price",
        "prize": "R500",
        "prizes": ["R500", "R300", "R200"],
        "winners": ["Uzzi", "Nike", "Adidas"]
      },
      {
        "name": "1voucher",
        "prize": "R500",
        "prizes": ["R250", "R150", "R100"],
        "winners": ["Uzzi", "Nike", "Adidas"]
      },
      {
        "name": "Cash Price",
        "prize": "R1000",
        "prizes": ["R500", "R300", "R200"],
        "winners": ["Uzzi", "Nike", "Adidas"]
      }
    ]
  };
}
