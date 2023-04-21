import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea/admin/screens/mo4mo/results/result_screen.dart';
import 'package:west_sea/common/models/recent.dart';
import 'package:west_sea/common/theme/pallete.dart';
import 'package:west_sea/common/models/competion.dart';
import 'package:west_sea/common/utils/date.dart';

import '../../../common/widget/body.dart';
import '../../../common/widget/promo.dart';
import '../../bindings/mo4mo/results_binding.dart';
import '../../controllers/mo4mo/mo4mo_ctrl.dart';

class AdminMo4moPage extends GetView<AdminMo4moController> {
  AdminMo4moPage({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController prize = TextEditingController();
  final TextEditingController prize1 = TextEditingController();
  final TextEditingController prize2 = TextEditingController();
  final TextEditingController prize3 = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: controller.dbRef.onValue.asBroadcastStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return body(snapshot.data?.snapshot.value);
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Something went wrong, Restart the app'),
            ),
          );
        }
      },
    );
  }

  GetBuilder<AdminMo4moController> body(var data) {
    return GetBuilder<AdminMo4moController>(
      builder: (controller) {
        CompetionModel competionModel =
            CompetionModel.fromMap(data['competition'] as Map<String, dynamic>);
        RecentList recentList = RecentList.fromMap(
          {"recentList": data['recents']},
        );
        return Body(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                profile(),
                const SizedBox(height: 25),
                ongoing(competionModel),
                SizedBox(height: Get.height * 0.07),
                const Text('Competions'),
                const SizedBox(height: 8),
                recents(recentList)
              ],
            ),
          ),
        );
      },
    );
  }

  Row profile() {
    return Row(
      children: [
        const CircleAvatar(backgroundColor: Colors.blueAccent),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'MO4MO ACCOUNT',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Admin',
              style: TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.blueAccent),
            ),
          ],
        ),
      ],
    );
  }

  Card ongoing(CompetionModel competionModel) {
    return Card(
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                competionModel.prize,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              competionModel.name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              competionModel.status,
              style: TextStyle(
                color: competionModel.status == "ONGOING"
                    ? const Color.fromARGB(255, 0, 68, 2)
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'First Prize',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  competionModel.prizes[0],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Second Prize',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  competionModel.prizes[1],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Third Prize',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  competionModel.prizes[2],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                )
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => const AdminResultsPage(),
                      binding: AdminResultsBinding(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.bgColor,
                    textStyle: const TextStyle(color: Colors.black),
                  ),
                  child: const Text(
                    'Results',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                competionModel.status != "ONGOING"
                    ? ElevatedButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'Add Competition',
                            backgroundColor: Pallete.bgColor,
                            content: addComp(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.bgColor,
                        ),
                        child: const Text(
                          'Add Competition',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () => controller.onEnd(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.bgColor,
                        ),
                        child: const Text(
                          'End Competition',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column addComp() {
    return Column(
      children: [
        inputTxt(name, 'Name'),
        const SizedBox(height: 10),
        inputTxt(prize, 'Prize(R300)'),
        const SizedBox(height: 10),
        inputTxt(prize1, 'Prize 1(R150)'),
        const SizedBox(height: 10),
        inputTxt(prize2, 'Prize 2(R100)'),
        const SizedBox(height: 10),
        inputTxt(prize3, 'Prize 3(R50)'),
        const SizedBox(height: 10),
        inputTxt(desc, 'Description'),
        const SizedBox(height: 10),
        inputTxt(endDate, 'End date(01/01/2023)'),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                if (name.text.isNotEmpty &&
                    prize.text.isNotEmpty &&
                    prize1.text.isNotEmpty &&
                    prize2.text.isNotEmpty &&
                    prize3.text.isNotEmpty &&
                    desc.text.isNotEmpty &&
                    endDate.text.isNotEmpty) {
                  var data = {
                    'id': date(),
                    'name': name.text,
                    'prizes': [prize1.text, prize2.text, prize3.text],
                    'prize': prize.text,
                    'desc': desc.text,
                    'status': 'ONGOING',
                    'endDate': endDate.text,
                    'contenders': [
                      {
                        "id": "tyttetrffdfsef",
                        "name": "Punter1",
                        "points": 27,
                        "p": 4,
                        "w": 3
                      },
                    ],
                    'results': [
                      {
                        "id": "fake",
                        "date": "fake",
                        "results": ["5", "24", "13", "17", "11", "34", "44"]
                      }
                    ],
                  };
                  CompetionModel competition = CompetionModel.fromMap(data);
                  controller.onAdd(competionModel: competition);
                  name.dispose();
                  prize.dispose();
                  prize1.dispose();
                  prize2.dispose();
                  prize3.dispose();
                  desc.dispose();
                  endDate.dispose();
                  navigator!.pop();
                } else {
                  if (!Get.isSnackbarOpen) {
                    Get.showSnackbar(const GetSnackBar(
                      duration: Duration(seconds: 2),
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                      message: 'Fill All Field',
                    ));
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Done'),
            ),
            ElevatedButton(
              onPressed: () {
                name.dispose();
                prize.dispose();
                prize1.dispose();
                prize2.dispose();
                prize3.dispose();
                desc.dispose();
                endDate.dispose();
                navigator!.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Discard'),
            ),
          ],
        )
      ],
    );
  }

  TextField inputTxt(TextEditingController txtCtrl, String hint) {
    return TextField(
      controller: txtCtrl,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
      ),
    );
  }

  SizedBox recents(RecentList recentList) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.23,
      child: ListView.separated(
        itemCount: recentList.recentList.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return SizedBox(
            width: Get.width * 0.35,
            child: PromoCard(competion: recentList.recentList[index]),
          );
        },
      ),
    );
  }

  Widget empty() {
    return SizedBox(
      height: Get.height * 0.2,
      width: Get.width,
      child: const Card(
        color: Colors.white,
        child: Center(child: Text('Not yet released')),
      ),
    );
  }
}
