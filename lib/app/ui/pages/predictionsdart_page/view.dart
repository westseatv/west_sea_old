// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:west_sea/app/controllers/home_controller.dart';
import 'package:west_sea/app/ui/pages/predictionsdart_page/launchtime.dart';
import 'package:west_sea/app/ui/pages/predictionsdart_page/teatime.dart';
import 'package:west_sea/services/data/firebase.dart';

import '../../../bindings/predictionsdart_binding.dart';
import '../../theme/apptheme.dart';

class PredictionsView extends GetView<HomeController> {
  const PredictionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      initState: (state) {
        controller.createInterstitialAd();
        controller.createBannerAd();
      },
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('westseatv predictions'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              feature(
                image: 'logo_49s.png',
                title: 'Lunchtime',
                onTap: () async {
                  Get.lazyPut(() => FirebaseDb());
                  controller.showInterstitialAd();
                  await 1.delay();
                  Get.to(
                    () => const Launchtime(),
                    binding: LunchtimeBinding(),
                  );
                },
              ),
              const SizedBox(height: 20),
              feature(
                image: 'logo_49s.png',
                title: 'Teatime',
                onTap: () async {
                  Get.lazyPut(() => FirebaseDb());
                  controller.showInterstitialAd();
                  await 1.delay();
                  Get.to(
                    () => const Teatime(),
                    binding: TeatimeBinding(),
                  );
                },
              ),
            ],
          ),
          bottomNavigationBar: controller.homeBannerAd == null
              ? null
              : StatefulBuilder(
                  builder: (context, setState) => SizedBox(
                    height: AdSize.banner.height.toDouble(),
                    width: AdSize.banner.width.toDouble(),
                    child: AdWidget(
                      ad: controller.homeBannerAd!,
                    ),
                  ),
                ),
        );
      },
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
