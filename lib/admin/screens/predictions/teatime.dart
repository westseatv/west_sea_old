import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/predictions/teatime.dart';

class AdminTeatimePage extends GetView<AdminTeatimeController> {
  const AdminTeatimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('teatime predictions'),
          bottom: const TabBar(
            tabs: [
              Text(
                '2 Balls',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '3 Balls',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Bonuses',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: body(),
        floatingActionButton: addDelete(context),
      ),
    );
  }

  Row addDelete(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          child: const Text('Add'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return add();
              },
            );
          },
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return clear();
              },
            );
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }

  Obx add() {
    return Obx(
      () => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 13, 34, 51),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              controller: controller.b,
              decoration: const InputDecoration(
                label: Text('Ball type (write 2, 3 or b)'),
                labelStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                controller.ball.value = value.trim();
              },
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: controller.ball.value == '2' ||
                  controller.ball.value == '3' ||
                  controller.ball.value == 'b',
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                controller: controller.b1TxtCtrl,
                decoration: InputDecoration(
                  label: Text(controller.b.text == 'b' ? 'Bonus' : 'Ball 1'),
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible:
                  controller.ball.value == '2' || controller.ball.value == '3',
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                controller: controller.b2TxtCtrl,
                decoration: const InputDecoration(
                  label: Text('Ball 2'),
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: controller.ball.value == '3',
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                controller: controller.b3TxtCtrl,
                decoration: const InputDecoration(
                  label: Text('Ball 3'),
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        actions: controller.ball.value == '2' ||
                controller.ball.value == '3' ||
                controller.ball.value == 'b'
            ? [
                MaterialButton(
                  color: Colors.red,
                  child: const Text('Cancel'),
                  onPressed: () {
                    controller.b.clear();
                    controller.b1TxtCtrl.clear();
                    controller.b2TxtCtrl.clear();
                    controller.b3TxtCtrl.clear();
                    controller.ball.value = '0';
                    navigator!.pop();
                  },
                ),
                MaterialButton(
                  color: Colors.green,
                  child: const Text('Add'),
                  onPressed: () {
                    String d = DateTime.now().day > 9
                        ? '${DateTime.now().day}'
                        : '0${DateTime.now().day}';
                    String m = DateTime.now().month > 9
                        ? '${DateTime.now().month}'
                        : '0${DateTime.now().month}';
                    String y = DateTime.now().year > 9
                        ? '${DateTime.now().year}'
                        : '0${DateTime.now().year}';
                    String h = DateTime.now().hour > 9
                        ? '${DateTime.now().hour}'
                        : '0${DateTime.now().hour}';
                    String min = DateTime.now().minute > 9
                        ? '${DateTime.now().minute}'
                        : '0${DateTime.now().minute}';

                    String date = '$d/$m/$y $h:$min';
                    switch (controller.ball.value) {
                      case '2':
                        if (controller.b1TxtCtrl.text.isNotEmpty &&
                            controller.b2TxtCtrl.text.isNotEmpty) {
                          controller.firebaseDb.onAddPrediction(
                            b: controller.b.text.trim(),
                            balls: [
                              controller.b1TxtCtrl.text.trim(),
                              controller.b2TxtCtrl.text.trim(),
                            ],
                            date: date,
                            whichOne: '',
                          );

                          controller.b1TxtCtrl.clear();
                          controller.b2TxtCtrl.clear();
                          controller.b3TxtCtrl.clear();
                        } else {
                          Get.showSnackbar(
                            const GetSnackBar(
                              message: 'Please enter all 2 balls',
                              backgroundColor: Colors.red,
                              snackPosition: SnackPosition.TOP,
                            ),
                          );
                        }
                        break;
                      case '3':
                        if (controller.b1TxtCtrl.text.isNotEmpty &&
                            controller.b2TxtCtrl.text.isNotEmpty &&
                            controller.b3TxtCtrl.text.isNotEmpty) {
                          controller.firebaseDb.onAddPrediction(
                            b: controller.b.text.trim(),
                            balls: [
                              controller.b1TxtCtrl.text.trim(),
                              controller.b2TxtCtrl.text.trim(),
                              controller.b3TxtCtrl.text.trim(),
                            ],
                            date: date,
                            whichOne: 'teatime',
                          );

                          controller.b1TxtCtrl.clear();
                          controller.b2TxtCtrl.clear();
                          controller.b3TxtCtrl.clear();
                        } else {
                          Get.showSnackbar(
                            const GetSnackBar(
                              message: 'Please enter all 3 balls',
                              backgroundColor: Colors.red,
                              snackPosition: SnackPosition.TOP,
                            ),
                          );
                        }
                        break;
                      case 'b':
                        if (controller.b1TxtCtrl.text.isNotEmpty) {
                          controller.firebaseDb.onAddPrediction(
                            b: controller.b.text.trim(),
                            balls: [controller.b1TxtCtrl.text.trim()],
                            date: date,
                            whichOne: 'teatime',
                          );

                          controller.b1TxtCtrl.clear();
                          controller.b2TxtCtrl.clear();
                          controller.b3TxtCtrl.clear();
                        } else {
                          Get.showSnackbar(
                            const GetSnackBar(
                              message: 'Please enter bonus ball',
                              backgroundColor: Colors.red,
                              snackPosition: SnackPosition.TOP,
                            ),
                          );
                        }
                        break;
                    }
                  },
                ),
              ]
            : null,
      ),
    );
  }

  Widget clear() {
    controller.b.clear();
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 13, 34, 51),
      content: TextField(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
        controller: controller.b,
        decoration: const InputDecoration(
          label: Text('2, 3, b or all'),
          labelStyle: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            controller.firebaseDb.clear(controller.b.text.trim(), 'teatime');
            controller.b.clear();
            navigator!.pop();
          },
          child: const Text('Clear'),
        ),
        ElevatedButton(
          onPressed: () {
            controller.b.clear();
            navigator!.pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  StreamBuilder<DatabaseEvent> body() {
    return StreamBuilder<DatabaseEvent>(
      stream: controller.firebaseDb.predictionsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading();
        } else {
          if (snapshot.hasData) {
            return TabBarView(
              children: [
                controller.firebaseDb.teatimeTwoBallPredictions.length < 2
                    ? empty()
                    : twoBall(),
                controller.firebaseDb.teatimeThreeBallPredictions.length < 2
                    ? empty()
                    : threeBall(),
                controller.firebaseDb.teatimeBonusesPredictions.length < 2
                    ? empty()
                    : bonuses(),
              ],
            );
          } else {
            return error();
          }
        }
      },
    );
  }

  ListView threeBall() {
    List<dynamic> balls = [];
    for (var p in controller.firebaseDb.teatimeThreeBallPredictions) {
      balls.add(p);
    }
    balls.assignAll(balls.reversed.toList());
    return ListView.builder(
      itemCount: balls.length - 1,
      itemBuilder: (context, index) {
        int j = 0;
        if (index > 0) {
          j = 3 * index;
        }

        return Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  ball(balls[index]['balls'][0], balls.length - 1, j, 3),
                  ball(balls[index]['balls'][1], balls.length - 1, j + 1, 3),
                  ball(balls[index]['balls'][2], balls.length - 1, j + 2, 3),
                ],
              ),
              subtitle: Column(
                children: [
                  const Divider(),
                  Text(
                    '${balls[index]['date']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 10),
          ],
        );
      },
    );
  }

  ListView twoBall() {
    List<dynamic> balls = [];
    for (var p in controller.firebaseDb.teatimeTwoBallPredictions) {
      balls.add(p);
    }
    balls.assignAll(balls.reversed.toList());
    return ListView.builder(
      itemCount: balls.length - 1,
      itemBuilder: (context, index) {
        int i = 0;
        if (index > 0) {
          i = 2 * index;
        }
        return Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  ball(balls[index]['balls'][0], balls.length - 1, i, 2),
                  ball(balls[index]['balls'][1], balls.length - 1, i + 1, 2),
                ],
              ),
              subtitle: Column(
                children: [
                  const Divider(),
                  Text(
                    '${balls[index]['date']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 10),
          ],
        );
      },
    );
  }

  ListView bonuses() {
    List<dynamic> balls = [];
    for (var p in controller.firebaseDb.teatimeBonusesPredictions) {
      balls.add(p);
    }
    balls.assignAll(balls.reversed.toList());
    return ListView.builder(
      itemCount: balls.length - 1,
      itemBuilder: (context, index) {
        int i = 0;
        if (index > 0) {
          i = 2 * index;
        }
        return Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  ball(balls[index]['ball'], balls.length - 1, i, 2),
                ],
              ),
              subtitle: Column(
                children: [
                  const Divider(),
                  Text(
                    '${balls[index]['date']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 10),
          ],
        );
      },
    );
  }

  Center loading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            strokeWidth: 5,
          ),
          SizedBox(height: 20),
          Text(
            'Loading...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Container ball(String number, int l, int i, int b) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: controller.colors(l, b)[i],
        shape: BoxShape.circle,
      ),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Text(
          number,
          style: const TextStyle(
            fontFamily: 'Tohama',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Center error() {
    return const Center(
      child: Text(
        'Something went wrong try to restart this app',
        style: TextStyle(
          color: Color.fromARGB(255, 163, 131, 131),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Center empty() {
    return const Center(
      child: Text(
        'Nor Predictions added yet...',
        style: TextStyle(
          color: Color.fromARGB(255, 163, 131, 131),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
