import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../routes/routes.dart';
import '../global_widgets/icon_txt_btn.dart';
import '../utils/app_icons_icons.dart';
import '../utils/url_opener.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Container(
          height: Get.height,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(),
          child: AlignedGridView.count(
            crossAxisCount: 2,
            itemCount: bodyBtns.length,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              return bodyBtns[index];
            },
          ),
        );
      },
    );
  }

  List<IconTextBtn> get bodyBtns {
    return [
      IconTextBtn(
        extent: Get.height * 0.4,
        onTap: () => openUrl(url: 'https://www.49s.co.uk/49s/results'),
        icon: AppIcons.lunchtime,
        title: 'Lunchtime',
      ),
      IconTextBtn(
        extent: Get.height * 0.4,
        onTap: () => openUrl(url: 'https://www.49s.co.uk/49s/results'),
        icon: AppIcons.teatime,
        title: 'Teatime',
      ),
      IconTextBtn(
        extent: Get.height * 0.4,
        onTap: () {
          Get.toNamed(Routes.generator);
          controller.showInterstitialAd();
        },
        icon: AppIcons.generator,
        title: 'Generator',
      ),
      IconTextBtn(
        extent: Get.height * 0.4,
        onTap: () => openUrl(url: 'https://www.youtube.com/@westseatv'),
        icon: AppIcons.youtube,
        title: 'Predictions',
      ),
    ];
  }
}
