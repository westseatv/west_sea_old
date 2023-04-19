import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea/common/models/result.dart';
import 'package:west_sea/common/theme/pallete.dart';

import '../../../../common/widget/body.dart';
import '../../../controllers/mo4mo/results_ctrl.dart';

class AdminResultsPage extends GetView<AdminResultsController> {
  const AdminResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminResultsController>(
      builder: (controller) {
        ResultsListModel resultsList =
            ResultsListModel.fromMap({"resultsList": Get.arguments});

        return Column(
          children: [
            Expanded(
              child: Body(
                child: ListView.separated(
                  itemCount: resultsList.resultsList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    index = resultsList.resultsList.length - 1 - index;
                    return Card(
                      color: const Color.fromARGB(255, 233, 224, 224),
                      child: ListTile(
                        title: Row(
                          children: resultsList.resultsList[index].results
                              .map((e) => ball(e))
                              .toList(),
                        ),
                        subtitle: Text(
                          resultsList.resultsList[index].date,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: Get.width,
              color: Pallete.grayshColor,
              child: FloatingActionButton.small(
                backgroundColor: Pallete.bgColor,
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            )
          ],
        );
      },
    );
  }

  Expanded ball(String e) {
    return Expanded(
      child: Container(
        height: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Pallete.bgColor,
            width: 2,
          ),
          shape: BoxShape.circle,
        ),
        child: Text(
          e,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
