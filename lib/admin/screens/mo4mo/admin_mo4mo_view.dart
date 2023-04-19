import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea/admin/screens/mo4mo/results/result_screen.dart';
import 'package:west_sea/common/models/recent.dart';
import 'package:west_sea/common/theme/pallete.dart';
import 'package:west_sea/common/models/competion.dart';

import '../../../common/widget/body.dart';
import '../../../common/widget/promo.dart';
import '../../bindings/mo4mo/results_binding.dart';
import '../../controllers/mo4mo/mo4mo_ctrl.dart';

class AdminMo4moPage extends GetView<AdminMo4moController> {
  const AdminMo4moPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminMo4moController>(
      builder: (controller) {
        CompetionModel competionModel = CompetionModel.fromMap(
            controller.data['competition'] as Map<String, dynamic>);
        RecentList recentList = RecentList.fromMap(
          {"recentList": controller.data['recents']},
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
                const Text('Recent Competions'),
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
                      arguments: competionModel.results,
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
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.bgColor,
                  ),
                  child: const Text(
                    'More',
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
            child: PromoCard(competion: recentList.recentList[0]),
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
