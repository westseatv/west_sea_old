import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:west_sea/app/controllers/home_controller.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({super.key});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  final ctrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            ctrl.createInterstitialAd();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Text(
          'COMING SOON...',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      bottomNavigationBar: ctrl.isBannerLoaded.value
          ? SizedBox(
              height: AdSize.banner.height.toDouble(),
              width: AdSize.banner.width.toDouble(),
              child: AdWidget(
                ad: ctrl.homeBannerAd,
              ),
            )
          : null,
    );
  }
}
