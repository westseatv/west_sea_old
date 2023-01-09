import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:west_sea/app/ui/pages/generator_screen.dart';
import '../../../controllers/generator_controller.dart';
import '../../theme/apptheme.dart';
import '../../utils/app_icons_icons.dart';
import '../../utils/url_opener.dart';
import '../home_page/home_page.dart';

class GeneratorPage extends GetView<GeneratorController> {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneratorController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            Get.off(() => const HomePage());
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Get.off(() => const HomePage()),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            body: const GeneratorScreen(),
            bottomNavigationBar: controller.isBannerLoaded.value
                ? SizedBox(
                    height: AdSize.banner.height.toDouble(),
                    width: AdSize.banner.width.toDouble(),
                    child: AdWidget(
                      ad: controller.generatorBannerAd,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          controller.drawerCtrl.toggleDrawer();
        },
        icon: ValueListenableBuilder<AdvancedDrawerValue>(
          valueListenable: controller.drawerCtrl,
          builder: (_, value, __) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                value.visible ? Icons.clear : Icons.menu,
                key: ValueKey<bool>(
                  value.visible,
                ),
                color: appThemeData.textTheme.bodySmall!.color,
              ),
            );
          },
        ),
      ),
      title: Text(
        'WEST SEA TV',
        style: appThemeData.textTheme.bodyText1!.copyWith(
          fontSize: 18,
        ),
      ),
      actions: actions,
    );
  }

  Widget drawer() {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => controller.drawerCtrl.hideDrawer(),
      child: SafeArea(
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
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/icon.jpg'),
              ),
              ListTile(
                onTap: () {
                  controller.drawerCtrl.hideDrawer();
                  controller.showInterstitialAd();
                  Get.back();
                },
                leading: const Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                title: Text(
                  'Home',
                  style: appThemeData.textTheme.bodySmall,
                ),
              ),
              ListTile(
                onTap: () {
                  controller.drawerCtrl.hideDrawer();
                  openUrl(
                    url: 'https://www.youtube.com/@westseatv',
                  );
                },
                leading: const Icon(
                  AppIcons.youtube,
                  color: Colors.red,
                ),
                title: Text(
                  'Preditions and Tips',
                  style: appThemeData.textTheme.bodySmall,
                ),
              ),
              ListTile(
                onTap: () {
                  controller.drawerCtrl.hideDrawer();
                  openUrl(
                    url:
                        'https://play.google.com/store/apps/details?id=com.zakaweezy.west_sea_app&hl=en&gl=US',
                  );
                },
                leading: const Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 253, 172, 22),
                ),
                title: Text(
                  'App Rating',
                  style: appThemeData.textTheme.bodySmall,
                ),
              ),
              ListTile(
                onTap: () {
                  controller.drawerCtrl.hideDrawer();
                  var link =
                      'https://play.google.com/store/apps/details?id=com.zakaweezy.west_sea_app&hl=en&gl=US';
                  Share.share(
                      'Download this app for UK 49\'s Results and Predictions \n\n $link');
                },
                leading: const Icon(
                  Icons.share,
                  color: Colors.greenAccent,
                ),
                title: Text(
                  'App Sharing',
                  style: appThemeData.textTheme.bodySmall,
                ),
              ),
              ListTile(
                onTap: () {
                  controller.drawerCtrl.hideDrawer();
                  openUrl(
                    url: 'http://westseatv.com/',
                  );
                },
                leading: const Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                title: Text(
                  'Our Website',
                  style: appThemeData.textTheme.bodySmall,
                ),
              ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    controller.drawerCtrl.hideDrawer();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: const Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get actions {
    return [
      IconButton(
        onPressed: () => openUrl(url: 'https://www.youtube.com/@westseatv'),
        icon: const Icon(
          AppIcons.youtube,
          color: Color.fromARGB(255, 196, 17, 17),
        ),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      IconButton(
        onPressed: () => openUrl(url: 'https://web.facebook.com/westseatv'),
        icon: const Icon(
          Icons.facebook_rounded,
          color: Color.fromARGB(255, 12, 1, 53),
        ),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      IconButton(
        onPressed: () {
          var link =
              'https://play.google.com/store/apps/details?id=com.zakaweezy.west_sea_app&hl=en&gl=US';
          Share.share(
              'Download this app for UK 49\'s Results and Predictions \n\n $link');
        },
        icon: const Icon(
          AppIcons.share,
          color: Color.fromARGB(255, 2, 54, 4),
        ),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    ];
  }
}
