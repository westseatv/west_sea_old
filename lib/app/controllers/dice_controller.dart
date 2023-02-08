import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../services/local_db.dart';
import '../ui/theme/dice_icons.dart';

const int maxFailedLoadAttempts = 3;

class AppDiceController extends GetxController {
  final advancedDrawerController = AdvancedDrawerController();
  bool again = true;
  late int coinAmount;
  late int diamondAmount;
  BannerAd? bannerAd;
  BannerAd? inlineAd;
  BannerAd? inlineAd1;
  BannerAd? inlineAd2;
  InterstitialAd? _interstitialAd;
  RewardedInterstitialAd? _rewardedInterstitialAd;
  RewardedAd? _rewardedAd;

  LocalDbService localDbService = Get.find<LocalDbService>();

  int _numInterstitialLoadAttempts = 0;
  int _numRewardedLoadAttempts = 0;
  int _numRewardedInterstitialLoadAttempts = 0;

  List<IconData> dices = [
    Dice.dice_1,
    Dice.dice_2,
    Dice.dice_3,
    Dice.dice_4,
    Dice.dice_5,
    Dice.dice_6,
  ];

  var isOneTossing = false.obs;
  var isTwoTossing = false.obs;
  var isFourTossing = false.obs;

  IconData one = Dice.dice_6;
  int numOne = 0;
  int onePredictions = 6;
  List<IconData> two = [Dice.dice_6, Dice.dice_6];
  List<int> numTwo = [0, 0];
  List<int> twoPredictions = [6, 6];
  List<IconData> four = [Dice.dice_6, Dice.dice_6, Dice.dice_6, Dice.dice_6];
  List<int> numFour = [0, 0, 0, 0];
  List<int> fourPredictions = [6, 6, 6, 6];

  int reset = 0;
  int playCounter = 0;

  void oneToss() {
    if (coinAmount > 2) {
      tossing(3);
      numOne = Random(Timeline.now * 857).nextInt(24) + 1;
      int i = -1;
      isOneTossing(true);

      Timer.periodic(
        const Duration(milliseconds: 100),
        (timer) async {
          reset = reset == 0 ? timer.tick - timer.tick + 1 : reset + 1;
          i++;
          if (i >= 6) {
            i = 0;
          }
          Get.log('Reset: $reset');
          Get.log('Number: $numOne');
          if (reset == numOne) {
            Get.log('${i + 1}');
            Get.log('DICE NUMBER:  ${i + 1}');
            one = dices[numOne % 6];
            reset = 0;

            timer.cancel();
            one = dices[i];
            isOneTossing(false);
            if (i + 1 == onePredictions) {
              localDbService.incrementDiamonds(1);
              diamondAmount = localDbService.diamondAmount();
              Get.showSnackbar(
                const GetSnackBar(
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.green,
                  snackPosition: SnackPosition.TOP,
                  message: 'Congratilations you won 1 diamond',
                ),
              );
            }
            update();
            await 2.delay();
          } else {
            one = dices[i];
            update();
          }
        },
      );
    } else {
      if (!Get.isSnackbarOpen) {
        Get.showSnackbar(
          const GetSnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            message: 'You don\'t have enough coins to toss',
          ),
        );
      }
    }
  }

  void twoToss() {
    if (coinAmount > 1) {
      List<bool> twoTraceWin = [false, false];
      tossing(2);
      numTwo.assignAll(
        List.generate(2, (index) {
          return (Random(index + 6 * Timeline.now ~/ 23).nextInt(30));
        }),
      );
      int maxi = 0;
      for (int j = 0; j < numTwo.length; j++) {
        maxi = max(maxi, numTwo[j]);
      }

      int i = -1;
      isTwoTossing(true);

      Timer.periodic(
        const Duration(milliseconds: 100),
        (timer) async {
          reset = reset == 0 ? timer.tick - timer.tick + 1 : reset + 1;
          i++;
          if (i >= 6) {
            i = 0;
          }
          if (reset < numTwo[0] && reset != 0) {
            two[0] = dices[i];
            update();
          }
          if (reset == numTwo[0]) {
            Get.log('Result 1: ${i + 1}');
            two[0] = dices[i];
            if (i + 1 == twoPredictions[0]) {
              twoTraceWin[0] = true;
            }
            update();
            // if (numTwo[0] == maxi) {
            //   timer.cancel();
            //   reset = 0;
            //   await 2.delay();
            //   isTwoTossing(false);
            //   update();
            // }
          }

          if (reset < numTwo[1] && reset != 0) {
            two[1] = dices[i];
            update();
          }

          if (reset == numTwo[1]) {
            Get.log('Result 2: ${i + 1}');
            two[1] = dices[i];
            if (i + 1 == twoPredictions[1]) {
              twoTraceWin[1] = true;
            }
            update();
          }
          if (reset == maxi) {
            timer.cancel();
            reset = 0;
            await 2.delay();
            isTwoTossing(false);

            bool won = twoTraceWin[0] && twoTraceWin[1];
            if (won) {
              localDbService.incrementDiamonds(2);
              diamondAmount = localDbService.diamondAmount();
              Get.showSnackbar(
                const GetSnackBar(
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.green,
                  snackPosition: SnackPosition.TOP,
                  message: 'Congratulations you won 2 diamond',
                ),
              );
            }
            update();
          }
        },
      );
    } else {
      if (!Get.isSnackbarOpen) {
        Get.showSnackbar(
          const GetSnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            message: 'You don\'t have enough coins to toss',
          ),
        );
      }
    }
  }

  void fourToss() {
    if (coinAmount > 0) {
      List<bool> fourTraceWin = [false, false, false, false];
      tossing(1);

      numFour.assignAll(
        List.generate(4, (index) {
          return (Random(index + 6 * Timeline.now ~/ 13 + 98 - 18998)
              .nextInt(30));
        }),
      );
      int maxi = 0;
      for (int j = 0; j < numFour.length; j++) {
        maxi = max(maxi, numFour[j]);
      }
      int i = -1;
      isFourTossing(true);

      Timer.periodic(
        const Duration(milliseconds: 100),
        (timer) async {
          reset = reset == 0 ? timer.tick - timer.tick + 1 : reset + 1;
          i++;
          if (i >= 6) {
            i = 0;
          }

          if (reset < numFour[0] && reset != 0) {
            four[0] = dices[i];
            update();
          }
          if (reset == numFour[0]) {
            four[0] = dices[i];
            if (i + 1 == fourPredictions[0]) {
              fourTraceWin[0] = true;
            }
            Get.log('Result 1: ${i + 1}');
            update();
          }

          if (reset < numFour[1] && reset != 0) {
            four[1] = dices[i];
            update();
          }

          if (reset == numFour[1]) {
            four[1] = dices[i];
            if (i + 1 == fourPredictions[1]) {
              fourTraceWin[1] = true;
            }
            Get.log('Result 2: ${i + 1}');
            update();
          }

          if (reset < numFour[2] && reset != 0) {
            four[2] = dices[i];

            update();
          }
          if (reset == numFour[2]) {
            four[2] = dices[i];
            if (i + 1 == fourPredictions[2]) {
              fourTraceWin[2] = true;
            }
            Get.log('Result 3: ${i + 1}');
            update();
          }

          if (reset < numFour[3] && reset != 0) {
            four[3] = dices[i];
            update();
          }

          if (reset == numFour[3]) {
            four[3] = dices[i];
            if (i + 1 == fourPredictions[3]) {
              fourTraceWin[3] = true;
            }
            Get.log('Result 4: ${i + 1}');
            update();
          }
          if (reset == maxi) {
            timer.cancel();
            reset = 0;
            await 2.delay();
            isFourTossing(false);
            bool won = fourTraceWin[0] &&
                fourTraceWin[1] &&
                fourTraceWin[2] &&
                fourTraceWin[3];

            if (won) {
              localDbService.incrementDiamonds(3);
              diamondAmount = localDbService.diamondAmount();
              Get.showSnackbar(
                const GetSnackBar(
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.green,
                  snackPosition: SnackPosition.TOP,
                  message: 'Congratilations you won 3 diamond',
                ),
              );
            }
            update();
          }
        },
      );
    } else {
      if (!Get.isSnackbarOpen) {
        Get.showSnackbar(
          const GetSnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            message: 'You don\'t have enough coins to toss',
          ),
        );
      }
    }
  }

  void getCoin({bool isFromReward = false, bool isFromBanner = false}) {
    int value = 0;
    if (isFromBanner) {
      value = 3;
    }
    if (isFromReward) {
      value = 1;
    }
    localDbService.incrementCoins(value);
    coinAmount = localDbService.coinAmount();
    update();
  }

  void buyDiamond(int q, int p) {
    if (coinAmount >= p) {
      localDbService.incrementDiamonds(q);
      localDbService.decrementCoins(p);
      diamondAmount = localDbService.diamondAmount();
      coinAmount = localDbService.coinAmount();
      if (!Get.isSnackbarOpen) {
        Get.showSnackbar(
          GetSnackBar(
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
            message: 'You bought $q Diamond(s) with $p Coins',
          ),
        );
      }
    } else {
      if (!Get.isSnackbarOpen) {
        Get.showSnackbar(
          const GetSnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            message:
                'You don\'t have enough coins to buy Diamomd, watch an to get coins',
          ),
        );
      }
    }

    update();
  }

  void tossing(int value) {
    playCounter++;
    if (coinAmount >= value) {
      localDbService.decrementCoins(value);
      coinAmount = localDbService.coinAmount();
      if (playCounter > 3) {
        showRewardedInterstitialAd();
        playCounter = 0;
      }
    }
    update();
  }

  final AdRequest request = const AdRequest(
    nonPersonalizedAds: true,
  );

  void createBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAd,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          Get.log('Banner Ad Loaded');
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          Get.log('Banner Ad failed to load');
        },
        onAdOpened: (ad) => Get.log('Banner ad openned'),
        onAdClicked: (ad) async {
          if (again) {
            getCoin(isFromBanner: true);
            again = false;
            await 10.delay();
            again = true;
          }
        },
        onAdClosed: (ad) => Get.log('Banner ad closed'),
      ),
      request: const AdRequest(),
    )..load();
  }

  void createInlineAd() {
    inlineAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.inlineAd,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          Get.log('Banner Ad Loaded');
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          Get.log('Banner Ad failed to load');
        },
        onAdOpened: (ad) => Get.log('Banner ad openned'),
        onAdClicked: (ad) async {
          if (again) {
            getCoin(isFromBanner: true);
            again = false;
            await 10.delay();
            again = true;
          }
        },
        onAdClosed: (ad) => Get.log('Banner ad closed'),
      ),
      request: const AdRequest(),
    )..load();
  }

  void createInlineAd1() {
    inlineAd1 = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.inlineAd1,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          Get.log('Banner Ad Loaded');
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          Get.log('Banner Ad failed to load');
        },
        onAdOpened: (ad) => Get.log('Banner ad openned'),
        onAdClicked: (ad) async {
          if (again) {
            getCoin(isFromBanner: true);
            again = false;
            await 10.delay();
            again = true;
          }
        },
        onAdClosed: (ad) => Get.log('Banner ad closed'),
      ),
      request: const AdRequest(),
    )..load();
  }

  void createInlineAd2() {
    inlineAd2 = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.inlineAd2,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          Get.log('Banner Ad Loaded');
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          Get.log('Banner Ad failed to load');
        },
        onAdOpened: (ad) => Get.log('Banner ad openned'),
        onAdClicked: (ad) async {
          if (again) {
            getCoin(isFromBanner: true);
            again = false;
            await 10.delay();
            again = true;
          }
        },
        onAdClosed: (ad) => Get.log('Banner ad closed'),
      ),
      request: const AdRequest(),
    )..load();
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAd,
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          Get.log('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          Get.log('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      Get.log('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          Get.log('ad onAdShowedFullScreenContent.'),
      onAdClicked: (ad) async {
        if (again) {
          getCoin(isFromBanner: true);
          again = false;
          await 10.delay();
          again = true;
        }
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        Get.log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        Get.log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: AdHelper.rewardedAd,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            Get.log('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            Get.log('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              createRewardedAd();
            }
          },
        ));
  }

  void showRewardedAd() {
    if (_rewardedAd == null) {
      Get.log('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          Get.log('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        Get.log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        Get.log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      getCoin(isFromReward: true);
      Get.log('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  void createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: AdHelper.interstitailRAd,
        request: request,
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            Get.log('$ad loaded.');
            _rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            Get.log('RewardedInterstitialAd failed to load: $error');
            _rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createRewardedInterstitialAd();
            }
          },
        ));
  }

  void showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      Get.log('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          Get.log('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        Get.log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        Get.log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedInterstitialAd();
      },
    );

    _rewardedInterstitialAd!.setImmersiveMode(true);
    _rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      getCoin(isFromReward: true);
      Get.log('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedInterstitialAd = null;
  }

  @override
  void onInit() {
    coinAmount = localDbService.coinAmount();
    diamondAmount = localDbService.diamondAmount();
    createBannerAd();
    createInlineAd();
    createInlineAd1();
    createInlineAd2();
    createInterstitialAd();
    createRewardedInterstitialAd();
    createRewardedAd();
    super.onInit();
  }

  @override
  void onClose() {
    bannerAd?.dispose();
    inlineAd?.dispose();
    inlineAd1?.dispose();
    inlineAd2?.dispose();
    _interstitialAd?.dispose();
    _rewardedInterstitialAd?.dispose();
    _rewardedAd?.dispose();
    advancedDrawerController.dispose();
    super.onClose();
  }
}

class AdHelper {
  //FOR TESTING
  /*
  static const bannerAd = 'ca-app-pub-3940256099942544/6300978111';
  static const inlineAd = 'ca-app-pub-3940256099942544/6300978111';
  static const inlineAd1 = 'ca-app-pub-3940256099942544/6300978111';
  static const inlineAd2 = 'ca-app-pub-3940256099942544/6300978111';
  static const interstitialAd = 'ca-app-pub-3940256099942544/1033173712';
  static const interstitailRAd = 'ca-app-pub-3940256099942544/5354046379';
  static const rewardedAd = 'ca-app-pub-3940256099942544/5224354917';
  */

  //FOR PRODUCTION

  static const bannerAd = 'ca-app-pub-7019809493231784/8607919033';
  static const inlineAd = 'ca-app-pub-7019809493231784/7542518871';
  static const inlineAd1 = 'ca-app-pub-7019809493231784/6729513546';
  static const inlineAd2 = 'ca-app-pub-7019809493231784/1028811914';
  static const interstitialAd = 'ca-app-pub-7019809493231784/5500192351';
  static const interstitailRAd = 'ca-app-pub-7019809493231784/3303890967';
  static const rewardedAd = 'ca-app-pub-7019809493231784/9729429016';
}
