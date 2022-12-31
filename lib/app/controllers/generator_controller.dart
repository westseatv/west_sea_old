import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_helper.dart';

class GeneratorController extends GetxController {
  final drawerCtrl = AdvancedDrawerController();
  List<int> generated = [];
  List<Color> colors = [];

  void generate() {
    int radNum;
    generated.assignAll(
      List.generate(
        7,
        (index) {
          radNum = Random(Timeline.now * (index + index + 1)).nextInt(49) + 1;
          while (generated.contains(radNum)) {
            radNum =
                Random(Timeline.now + (index + index + 20)).nextInt(49) + 1;
          }
          return radNum;
        },
      ),
    );
    colors.assignAll(
      List.generate(
        7,
        (i) {
          int r = Random(Timeline.now * (i + 30)).nextInt(150) + 50;
          int g = Random(Timeline.now * (i + 10)).nextInt(150) + 50;
          int b = Random(Timeline.now * (i + 20)).nextInt(150) + 50;

          return Color.fromARGB(255, r, g, b);
        },
      ),
    );
  }

  late BannerAd generatorBannerAd;
  InterstitialAd? generatorInterstitial;
  var isBannerLoaded = false.obs;
  int attempts = 0;

  @override
  void onInit() {
    super.onInit();
    generate();
    createBannerAd();
    createInterstitialAd();
    generatorBannerAd.load();
  }

  void createBannerAd() {
    generatorBannerAd = BannerAd(
      adUnitId: AdHelper.generatorBannerAd,
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isBannerLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          generatorBannerAd.dispose();
        },
      ),
      request: const AdRequest(),
    );
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.generatorInterstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          generatorInterstitial = ad;
        },
        onAdFailedToLoad: (error) {
          generatorInterstitial = null;
          attempts += 1;

          if (attempts >= 5) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (generatorInterstitial != null) {
      generatorInterstitial!.fullScreenContentCallback =
          FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createBannerAd();
        },
      );
      generatorInterstitial!.show();
    }
  }

  @override
  void onClose() {
    drawerCtrl.dispose();
    generatorBannerAd.dispose();
    generatorInterstitial?.dispose();
    super.onClose();
  }
}
