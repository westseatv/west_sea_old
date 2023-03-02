import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea/app/ui/pages/predictionsdart_page/launchtime.dart';
import 'package:west_sea/app/ui/pages/predictionsdart_page/teatime.dart';

import '../../../bindings/predictionsdart_binding.dart';
import '../../theme/apptheme.dart';

class PredictionsView extends StatelessWidget {
  const PredictionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('westseatv predictions'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          feature(
            image: 'launchtime.png',
            title: 'Lunchtime',
            onTap: () {
              Get.to(
                () => const Launchtime(),
                binding: PredictionsBinding(),
              );
            },
          ),
          const SizedBox(height: 20),
          feature(
            image: 'teatime.png',
            title: 'Teatime',
            onTap: () {
              Get.to(
                () => const Teatime(),
                binding: PredictionsBinding(),
              );
            },
          ),
        ],
      ),
    );
  }

  InkWell feature(
      {required String image,
      required String title,
      required VoidCallback onTap}) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        height: Get.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/$image'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: appThemeData.textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
