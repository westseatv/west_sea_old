import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ad_helper.dart';

class HomeController extends GetxController {
  final drawerCtrl = AdvancedDrawerController();
  late BannerAd homeBannerAd;
  InterstitialAd? homeInterstitial;
  var isBannerLoaded = false.obs;
  int attempts = 0;


  @override
  void onReady() {
    createBannerAd();
    createInterstitialAd();
    super.onReady();
  }

  void createBannerAd() {
    homeBannerAd = BannerAd(
      adUnitId: AdHelper.homeBannerAd,
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isBannerLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          homeBannerAd.dispose();
        },
      ),
      request: const AdRequest(),
    );
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.homeInterstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          homeInterstitial = ad;
        },
        onAdFailedToLoad: (error) {
          homeInterstitial = null;
          attempts += 1;

          if (attempts >= 5) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (homeInterstitial != null) {
      homeInterstitial!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createBannerAd();
        },
      );
      homeInterstitial!.show();
    }
  }

  Future<bool?> showWarning(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Exit App?',
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                'Yes',
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text(
                'No',
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );

  @override
  void onClose() {
    drawerCtrl.dispose();
    homeBannerAd.dispose();
    homeInterstitial?.dispose();
    super.onClose();
  }
}
