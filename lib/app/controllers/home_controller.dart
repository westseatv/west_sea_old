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
  void onInit() {
    super.onInit();
    createBannerAd();
    createInterstitialAd();
    homeBannerAd.load();
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

  @override
  void onClose() {
    drawerCtrl.dispose();
    homeBannerAd.dispose();
    homeInterstitial?.dispose();
    super.onClose();
  }
}
