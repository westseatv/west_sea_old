import 'package:firebase_database/firebase_database.dart';
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
    return StreamBuilder<DatabaseEvent>(
        stream: controller.resultsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
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
        });
  }

  GetBuilder<AdminResultsController> body(var data) {
    return GetBuilder<AdminResultsController>(
      builder: (controller) {
        ResultsListModel resultsList =
            ResultsListModel.fromMap({"resultsList": data});

        return resultsList.resultsList.length < 2
            ? Body(
                floating: FloatingActionButton.small(
                  backgroundColor: Pallete.bgColor,
                  onPressed: () {
                    Get.bottomSheet(
                      Column(
                        children: [
                          ListTile(
                            title: Obx(
                              () => Row(
                                children: controller.generated
                                    .map((e) => ball(e))
                                    .toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () => controller.generate(),
                                child: const Text('Generate'),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () => controller.onAddResults(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text('Release'),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                      backgroundColor: Pallete.bgColor,
                    );
                  },
                  child: const Icon(Icons.add),
                ),
                child: const Center(child: Text('Add Results')),
              )
            : Body(
                floating: controller.alreadyAdded(
                        resultsList.resultsList.map((e) => e.id).toList())
                    ? null
                    : FloatingActionButton.small(
                        backgroundColor: Pallete.bgColor,
                        onPressed: () {
                          Get.bottomSheet(
                            Column(
                              children: [
                                ListTile(
                                  title: Obx(
                                    () => Row(
                                      children: controller.generated
                                          .map((e) => ball(e))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Generate'),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                      onPressed: () =>
                                          controller.onAddResults(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      child: const Text('Release'),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ],
                            ),
                            backgroundColor: Pallete.bgColor,
                          );
                        },
                        child: const Icon(Icons.add),
                      ),
                child: ListView.separated(
                  itemCount: resultsList.resultsList.length - 1,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    index = resultsList.resultsList.length - 1 - index;
                    return Card(
                      color: const Color.fromARGB(255, 212, 212, 212),
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
