import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:west_sea/app/ui/pages/dice/app_dice_page.dart';

import '../../../controllers/rewards_controller.dart';
import '../../core/constants.dart';

class RewardsPage extends GetView<RewardsController> {
  const RewardsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardsController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                controller.appDiceController.createBannerAd();
                controller.appDiceController.createInlineAd();
                controller.appDiceController.createInlineAd1();
                controller.appDiceController.createInlineAd2();
                Get.off(() => const AppDicePage());
              },
            ),
            title: const Text('Rewards'),
            actions: [
              Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Text(
                      'Balance: ${controller.localDbService.getInt('diamonds')}',
                      style: const TextStyle(
                        fontFamily: 'Tahoma',
                        fontSize: 18,
                      ),
                    ),
                    SvgPicture.asset(
                      SvgPath.diamond,
                      height: 20,
                      width: 20,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: StreamBuilder<DatabaseEvent>(
            stream: controller.diceFirebaseDb.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return waitimg();
              } else {
                if (snapshot.hasData) {
                  List<dynamic>? data = snapshot.data!.snapshot.value as List?;

                  return data!.length > 1
                      ? SizedBox(
                          height: Get.height,
                          width: Get.width,
                          child: rewards(data, context),
                        )
                      : noRewards();
                } else {
                  return error();
                }
              }
            },
          ),
        );
      },
    );
  }

  Center error() {
    return const Center(
      child: Text(
        'Something went wrong try to restart this app',
        style: TextStyle(
          color: Color.fromARGB(255, 163, 131, 131),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Center noRewards() {
    return const Center(
      child: Text(
        'Out of Vouchers they will be added soon...',
        style: TextStyle(
          color: Color.fromARGB(255, 163, 131, 131),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget rewards(List<dynamic> data, BuildContext context) {
    return ListTileTheme(
      textColor: Colors.white,
      tileColor: Colors.blueAccent,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount: data.length - 1,
        itemBuilder: (context, index) {
          int i = index + 1;
          return ListTile(
            title: Text(
              '${data[i]['name']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              data[i]['isClaimed'] == 1 ? data[i]['desc'] : 'Claimed',
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.red,
                  backgroundColor: Colors.green),
              onPressed: data[i]['isClaimed'] == 1
                  ? () {
                      if (controller.localDbService.getInt('diamonds') >=
                          data[i]['cost']) {
                        controller.diceFirebaseDb.onGetReward(
                          name: data[i]['name'],
                          value: data[i]['value'],
                          desc: data[i]['desc'],
                          cost: data[i]['cost'],
                          index: i,
                        );
                        controller.localDbService
                            .dencrementDiamonds(data[i]['cost']);
                        controller.appDiceController.diamondAmount =
                            controller.localDbService.diamondAmount();
                        showDialog(
                          context: context,
                          builder: (context) => rewardDialog(
                            context,
                            data[i]['name'],
                            data[i]['value'],
                          ),
                        );
                        controller.update();
                      } else {
                        Get.showSnackbar(
                          const GetSnackBar(
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.red,
                            snackPosition: SnackPosition.TOP,
                            message:
                                'You Don\'t have enough diamonds to get this reward play or buy diamonds with coins ',
                          ),
                        );
                      }
                    }
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${data[i]['cost']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
            ),
          );
        },
      ),
    );
  }

  Center waitimg() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            strokeWidth: 5,
          ),
          SizedBox(height: 20),
          Text(
            'Loading...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  AlertDialog rewardDialog(BuildContext context, String name, String value) {
    return AlertDialog(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: Text(name),
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              tileColor: Colors.blue,
              title: Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.copy, color: Colors.white),
                onPressed: () => Clipboard.setData(
                  ClipboardData(text: value),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Copy your voucher and keep it safe or use it now if lost it there is nowhere you will find it',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 26, 21, 21),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            controller.appDiceController.showRewardedAd();
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
}
