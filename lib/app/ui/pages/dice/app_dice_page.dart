import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:west_sea/app/routes/routes.dart';

import '../../../controllers/dice_controller.dart';
import '../../core/constants.dart';
import '../../theme/dice_icons.dart';

class AppDicePage extends GetView<AppDiceController> {
  const AppDicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Theme.of(context).appBarTheme.backgroundColor,
      controller: controller.advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: drawer(context),
      child: GetBuilder<AppDiceController>(
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => rewardDialog(context, 5),
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          SvgPath.reward,
                          height: 30,
                          width: 30,
                          color: Colors.amber,
                        ),
                        Text(
                          '(${controller.numberOfReward})',
                          style: const TextStyle(
                            fontFamily: 'Tahoma',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              leading: IconButton(
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: controller.advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
              title: const Text('The Plug'),
            ),
            body: child(context),
            bottomNavigationBar: controller.bannerAd == null
                ? null
                : bannerAd(52, controller.bannerAd as AdWithView),
          );
        },
      ),
    );
  }

  SafeArea drawer(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: ListView(
          children: [
            Container(
              width: 128.0,
              height: 128.0,
              margin: const EdgeInsets.only(
                top: 24.0,
                bottom: 64.0,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/icon.jpg'),
            ),
            ListTile(
              tileColor: Colors.grey,
              onTap: () {
                controller.showInterstitialAd();
                controller.advancedDrawerController.hideDrawer();
                Get.offAllNamed(Routes.home);
              },
              leading: const Icon(Icons.home),
              title: const Text('Home Page'),
            ),
            const SizedBox(height: 15),
            ListTile(
              tileColor: Colors.blue,
              onTap: () {
                controller.showInterstitialAd();
                showDialog(
                  context: context,
                  builder: (context) {
                    return diamondDialog(context, controller.diamondAmount);
                  },
                );
                controller.advancedDrawerController.hideDrawer();
              },
              leading: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  SvgPath.diamond,
                  color: Colors.white,
                ),
              ),
              title: const Text('Get Diamonds'),
            ),
            const SizedBox(height: 15),
            ListTile(
              onTap: () {
                controller.showInterstitialAd();
                showDialog(
                  context: context,
                  builder: (context) {
                    return rewardDialog(context, controller.numberOfReward);
                  },
                );
                controller.advancedDrawerController.hideDrawer();
              },
              tileColor: Colors.deepPurpleAccent,
              leading: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  SvgPath.reward,
                  color: Colors.white,
                ),
              ),
              title: const Text('Get Rewards'),
            ),
            const SizedBox(height: 15),
            ListTile(
              onTap: () {
                controller.showInterstitialAd();
                showDialog(
                  context: context,
                  builder: (context) {
                    return coinDialog(context, controller.coinAmount);
                  },
                );
                controller.advancedDrawerController.hideDrawer();
              },
              tileColor: Colors.yellow,
              leading: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  SvgPath.coin,
                  color: Colors.white,
                ),
              ),
              title: const Text('Get Coins'),
            ),
            const SizedBox(height: 15),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return howToPlayDialog(context);
                  },
                );
                controller.advancedDrawerController.hideDrawer();
              },
              tileColor: Colors.green,
              leading: const Icon(Icons.help_sharp),
              title: const Text('How to Play'),
            ),
          ],
        ),
      ),
    );
  }

  StatefulBuilder bannerAd(double h, AdWithView ad) {
    return StatefulBuilder(
      builder: (context, setState) => Container(
        height: h,
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 10),
        child: AdWidget(ad: ad),
      ),
    );
  }

  Widget child(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              transBtn(
                txt: '${controller.coinAmount} Coins',
                onTab: () {
                  controller.showInterstitialAd();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return coinDialog(context, controller.coinAmount);
                    },
                  );
                },
              ),
              const SizedBox(width: 10),
              transBtn(
                txt: '${controller.diamondAmount} Diamonds',
                color: Colors.blue,
                onTab: () {
                  controller.showRewardedInterstitialAd();
                  showDialog(
                    context: context,
                    builder: (context) =>
                        diamondDialog(context, controller.diamondAmount),
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              oneSelection(context: context),
              controller.inlineAd != null
                  ? bannerAd(Get.height * 0.10, controller.inlineAd!)
                  : const SizedBox.shrink(),
              twoSelection(context: context),
              controller.inlineAd1 != null
                  ? bannerAd(Get.height * 0.10, controller.inlineAd1!)
                  : const SizedBox.shrink(),
              fourSelection(context: context),
              controller.inlineAd2 != null
                  ? bannerAd(Get.height * 0.10, controller.inlineAd2!)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  AlertDialog rewardDialog(BuildContext context, int numOfRewards) {
    return AlertDialog(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: Center(
        child: RichText(
          text: TextSpan(
            text: numOfRewards > 1 ? 'We have ' : 'You out of Rewards',
            style: const TextStyle(fontWeight: FontWeight.bold),
            children: numOfRewards > 1
                ? [
                    TextSpan(
                      text: '$numOfRewards',
                      style: TextStyle(
                        color: numOfRewards > 5
                            ? Colors.green
                            : numOfRewards > 3
                                ? Colors.yellow
                                : Colors.red,
                        fontFamily: 'Ghostclan',
                        fontSize: 25,
                      ),
                    ),
                    TextSpan(text: numOfRewards > 1 ? ' Rewards' : 'Reward')
                  ]
                : null,
          ),
        ),
      ),
      content: Container(
        height: Get.height * 0.60,
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            navigator?.pop();
            showDialog(
              context: context,
              builder: (context) =>
                  diamondDialog(context, controller.diamondAmount),
            );
          },
          icon: const Icon(Icons.video_collection),
          label: const Text(
            'Get Diamonds',
            style: TextStyle(fontFamily: 'Tahoma'),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            navigator?.pop();
          },
          icon: const Icon(Icons.close),
          label: const Text(
            'Close',
            style: TextStyle(fontFamily: 'Tahoma'),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }

  AlertDialog coinDialog(BuildContext context, int coinAmount) {
    return AlertDialog(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: Center(
        child: RichText(
          text: TextSpan(
            text: coinAmount > 1 ? 'You have ' : 'You out of Coins',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white12),
            children: coinAmount > 1
                ? [
                    TextSpan(
                      text: '$coinAmount',
                      style: TextStyle(
                        color: coinAmount >= 5
                            ? Colors.green
                            : coinAmount > 3
                                ? Colors.yellow
                                : Colors.red,
                        fontFamily: 'Ghostclan',
                        fontSize: 25,
                      ),
                    ),
                    TextSpan(text: coinAmount > 1 ? ' Coins' : 'Coin')
                  ]
                : null,
          ),
        ),
      ),
      content: SizedBox(
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            text: 'To  get coins you can ',
            style: TextStyle(
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: 'watch video ad',
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
              TextSpan(
                text: ' or ',
                children: [
                  TextSpan(
                    text: 'CLICK ANY AD DISPLAYED AD AND WAIT FOR A SECOND.',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  TextSpan(
                    text: ' Click in any ad is worthy of 3 coins',
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            controller.getCoin(isFromBanner: true);
          },
          icon: const Icon(Icons.video_collection),
          label: const Text(
            'Watch Ad',
            style: TextStyle(fontFamily: 'Tahoma'),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            navigator?.pop();
          },
          icon: const Icon(Icons.close),
          label: const Text(
            'Close',
            style: TextStyle(fontFamily: 'Tahoma'),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }

  AlertDialog diamondDialog(BuildContext context, int diamondAmount) {
    return AlertDialog(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: const Text('BUY DIAMONS'),
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      content: SizedBox(
        width: Get.width * 0.7,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buyTile(1, 10),
              buyTile(5, 50),
              buyTile(10, 100),
              buyTile(15, 150),
              buyTile(20, 200),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            controller.getCoin(isFromBanner: true);
          },
          icon: const Icon(Icons.video_collection),
          label: const Text(
            'Watch Ad',
            style: TextStyle(fontFamily: 'Tahoma'),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            navigator?.pop();
          },
          icon: const Icon(Icons.close),
          label: const Text(
            'Close',
            style: TextStyle(fontFamily: 'Tahoma'),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }

  ListTile buyTile(int q, int p) {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                '$q ',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SvgPicture.asset(
                SvgPath.diamond,
                color: Colors.blue,
                height: 20,
                width: 20,
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  ' = $p ',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SvgPicture.asset(
                  SvgPath.coin,
                  color: Colors.amber,
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      tileColor: Colors.white12,
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () {
          controller.buyDiamond(q, p);
        },
        child: const Text('Buy'),
      ),
    );
  }

  AlertDialog howToPlayDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: const Center(child: Text('How To Play')),
      content: Container(
        height: Get.height * 0.60,
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            navigator?.pop();
          },
          icon: const Icon(Icons.close),
          label: const Text(
            'Close',
            style: TextStyle(fontFamily: 'Tahoma'),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }

  Expanded transBtn({String? txt, VoidCallback? onTab, Color? color}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.amber[600],
        ),
        onPressed: onTab ?? () {},
        child: Text(
          txt ?? 'Diamonds',
          style: const TextStyle(
            fontFamily: 'Tahoma',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Row worth({required int amount, required String name, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          amount > 9
              ? '$amount'
              : amount > 0
                  ? '0$amount'
                  : '$amount',
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        SvgPicture.asset(
          name,
          color: color ?? Colors.blue,
          height: 25,
          width: 25,
        ),
      ],
    );
  }

  Widget choice(
      {int? number, double? size, Color? color, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size ?? Get.width * 0.50,
        width: size ?? Get.width * 0.50,
        alignment: Alignment.center,
        child: Container(
          height: size ?? Get.width * 0.50,
          width: size ?? Get.width * 0.50,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: size == null ? 30 : 15),
          decoration: BoxDecoration(
            color: color ?? Colors.purple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            number != null ? '$number' : '6',
            style: TextStyle(
              fontSize: size != null ? 25 : 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Icon dice({IconData? dice, Color? color, double? size}) {
    return Icon(
      dice ?? Dice.dice_6,
      size: size ?? Get.width * 0.50,
      color: color ?? Colors.purple,
    );
  }

  Widget oneSelection({required BuildContext context}) {
    double size = Get.width * 0.25;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xff880f4e),
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                const Text(
                  'One Dice',
                  style: TextStyle(
                    fontFamily: 'Tahoma',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 4,
                  children: [
                    dice(dice: controller.one, size: size),
                    choice(
                      number: controller.onePredictions,
                      size: size,
                      onTap: () {
                        onPredicting(context, Colors.purple, 1, 1);
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: controller.isOneTossing.isFalse
                      ? () {
                          controller.oneToss();
                        }
                      : null,
                  child: const Text(
                    'Toss',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff880f4e),
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text('3 '),
                SvgPicture.asset(
                  SvgPath.coin,
                  color: Colors.amber,
                  height: 10,
                  width: 10,
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: -1,
          top: -1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff880f4e),
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text('1 '),
                SvgPicture.asset(
                  SvgPath.diamond,
                  color: Colors.blue,
                  height: 10,
                  width: 10,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget twoSelection({required BuildContext context}) {
    double size = Get.width * 0.25;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xff880f4e),
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Two Dices',
                  style: TextStyle(
                    fontFamily: 'Tahoma',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  children: [
                    dice(dice: controller.two[0], size: size),
                    choice(
                      number: controller.twoPredictions[0],
                      onTap: () {
                        onPredicting(context, Colors.purple, 2, 0);
                      },
                      size: size,
                    ),
                    dice(
                      dice: controller.two[1],
                      color: Colors.yellow,
                      size: size,
                    ),
                    choice(
                      number: controller.twoPredictions[1],
                      color: Colors.yellow,
                      size: size,
                      onTap: () {
                        onPredicting(context, Colors.yellow, 2, 1);
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: controller.isTwoTossing.isFalse
                      ? () {
                          controller.twoToss();
                        }
                      : null,
                  child: const Text(
                    'Toss',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff880f4e),
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text('2 '),
                SvgPicture.asset(
                  SvgPath.coin,
                  color: Colors.amber,
                  height: 10,
                  width: 10,
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: -1,
          top: -1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff880f4e),
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text('2 '),
                SvgPicture.asset(
                  SvgPath.diamond,
                  color: Colors.blue,
                  height: 10,
                  width: 10,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget fourSelection({required BuildContext context}) {
    double size = Get.width * 0.20;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xff880f4e),
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                const Text(
                  'four Dices',
                  style: TextStyle(
                    fontFamily: 'Tahoma',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StaggeredGrid.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  children: [
                    dice(dice: controller.four[0], size: size),
                    dice(
                        dice: controller.four[1],
                        size: size,
                        color: Colors.green),
                    choice(
                      number: controller.fourPredictions[0],
                      size: size,
                      onTap: () {
                        onPredicting(context, Colors.purple, 4, 0);
                      },
                    ),
                    choice(
                      number: controller.fourPredictions[1],
                      size: size,
                      color: Colors.green,
                      onTap: () {
                        onPredicting(context, Colors.green, 4, 1);
                      },
                    ),
                    dice(
                        dice: controller.four[2],
                        size: size,
                        color: Colors.yellow),
                    dice(
                        dice: controller.four[3],
                        size: size,
                        color: Colors.pinkAccent[700]),
                    choice(
                      number: controller.fourPredictions[2],
                      size: size,
                      color: Colors.yellow,
                      onTap: () {
                        onPredicting(context, Colors.yellow, 4, 2);
                      },
                    ),
                    choice(
                      number: controller.fourPredictions[3],
                      size: size,
                      color: Colors.pinkAccent[700],
                      onTap: () {
                        onPredicting(context, Colors.pinkAccent[700], 4, 3);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: controller.isFourTossing.isFalse
                      ? () {
                          controller.fourToss();
                        }
                      : null,
                  child: const Text(
                    'Toss',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff880f4e),
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text('1 '),
                SvgPicture.asset(
                  SvgPath.coin,
                  color: Colors.amber,
                  height: 10,
                  width: 10,
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: -1,
          top: -1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff880f4e),
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text('3 '),
                SvgPicture.asset(
                  SvgPath.diamond,
                  color: Colors.blue,
                  height: 10,
                  width: 10,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> onPredicting(
      BuildContext context, Color? color, int i, int w) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          color: color ?? Colors.purple,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: List.generate(
                  3,
                  (index) => Expanded(
                    child: Container(
                      height: Get.width * 0.10,
                      width: Get.width * 0.10,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color ?? Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          switch (i) {
                            case 1:
                              controller.onePredictions = index + 1;
                              break;
                            case 2:
                              controller.twoPredictions[w] = index + 1;
                              break;
                            case 4:
                              controller.fourPredictions[w] = index + 1;
                              break;
                            default:
                          }
                          controller.update();
                          navigator?.pop();
                        },
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: List.generate(
                  3,
                  (index) => Expanded(
                    child: Container(
                      height: Get.width * 0.10,
                      width: Get.width * 0.10,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color ?? Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          switch (i) {
                            case 1:
                              controller.onePredictions = index + 4;
                              break;
                            case 2:
                              controller.twoPredictions[w] = index + 4;
                              break;
                            case 4:
                              controller.fourPredictions[w] = index + 4;
                              break;
                            default:
                          }
                          controller.update();
                          navigator?.pop();
                        },
                        child: Text(
                          '${index + 4}',
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    controller.advancedDrawerController.showDrawer();
  }
}

/*


import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advanced Drawer Example'),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: Container(),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/flutter_logo.png',
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.favorite),
                  title: Text('Favourites'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}

 */
