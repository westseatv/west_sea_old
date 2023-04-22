import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/generator_controller.dart';

class GeneratorScreen extends GetView<GeneratorController> {
  const GeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneratorController>(builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: const [
              SizedBox(width: 30),
              Text(
                'Main Numbers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                'Bonus',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: balls,
          ),
          const SizedBox(height: 20),
          Center(
            child: MaterialButton(
              color: Colors.red,
              onPressed: () {
                controller.generate();

                controller.update();
              },
              splashColor: Colors.blueGrey,
              child: const Text(
                'Generate',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      );
    });
  }

  List<Widget> get balls {
    return [
      const SizedBox(width: 10),
      ball(controller.generated[0], 0),
      ball(controller.generated[1], 1),
      ball(controller.generated[2], 2),
      ball(controller.generated[3], 3),
      ball(controller.generated[4], 4),
      ball(controller.generated[5], 5),
      const Spacer(),
      ball(controller.generated[6], 6),
      const SizedBox(width: 10),
    ];
  }

  Container ball(int number, int i) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(left: 2),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: controller.colors[i],
        shape: BoxShape.circle,
      ),
      child: Container(
        width: 30,
        height: 30,
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
