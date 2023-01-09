import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/predictionsdart_controller.dart';
import '../../utils/fake.dart';

class PredictionsPage extends GetView<PredictionsControler> {
  const PredictionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PredictionsControler>(builder: (controller) {
      int  j = 0;
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Admin\'s Predictions'),
            bottom: const TabBar(
              tabs: [
                Text(
                  '2 Balls',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '3 Balls',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: Fakes.twoBalls().length,
                itemBuilder: (context, index) {
                  final balls = Fakes.twoBalls();
                  int i = 0;
                  if (index > 0) {
                    i = 2 * index;
                  }

                  return Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            ball(
                                balls[index]['numbers'][0], balls.length, i, 2),
                            ball(
                                balls[index]['numbers'][1], balls.length, i+1, 2),
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
              ),
              ListView.builder(
                itemCount: Fakes.threeBalls().length,
                itemBuilder: (context, index) {
                  final balls = Fakes.threeBalls();
                  int j = 0;
                  if(index > 0){
                    j = 3*index;                    
                  }

                  return Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            ball(
                                balls[index]['numbers'][0], balls.length, j, 3),
                            ball(
                                balls[index]['numbers'][1], balls.length, j+1, 3),
                            ball(
                                balls[index]['numbers'][2], balls.length, j+2, 3),
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
              ),
            ],
          ),
        ),
      );
    });
  }

  Container ball(int number, int l, int i, int b) {
    return Container(
      alignment: Alignment.center,
      width: 50,
      height: 50,
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
          number < 10 ? '0$number' : '$number',
          style: const TextStyle(
            fontFamily: 'Tohama',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
