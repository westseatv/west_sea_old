import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:west_sea/app/ui/pages/coming_soon.dart';
import '../../../controllers/home_controller.dart';
import '../../../routes/routes.dart';
import '../../theme/apptheme.dart';
import '../../utils/app_icons_icons.dart';
import '../../utils/url_opener.dart';
import '../../global_widgets/icon_txt_btn.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          Future<bool> will = false as Future<bool>;
          Future<bool> willPop = Get.defaultDialog<bool>(
            onConfirm: () {
              Navigator.pop(context);
            },
            onCancel: () {
              Navigator.pop(context);
            },
            title: 'EXIT APP?',
            middleText: "",
            textConfirm: 'Yes',
            textCancel: 'No',
            onWillPop: () async => will,
          ) as Future<bool>;
          return willPop;
        },
        child: AdvancedDrawer(
            backdropColor: Colors.blueGrey,
            controller: controller.drawerCtrl,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            rtlOpening: false,
            disabledGestures: false,
            childDecoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 0.0,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            drawer: drawer(),
            child: Scaffold(
              appBar: appBar(),
              body: AlignedGridView.count(
                crossAxisCount: 2,
                itemCount: bodyBtns.length,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemBuilder: (context, index) {
                  return bodyBtns[index];
                },
              ),
              bottomNavigationBar: controller.isBannerLoaded.value
                  ? SizedBox(
                      height: AdSize.banner.height.toDouble(),
                      width: AdSize.banner.width.toDouble(),
                      child: AdWidget(
                        ad: controller.homeBannerAd,
                      ),
                    )
                  : null,
            )),
      );
    });
  }

  List<Widget> get bodyBtns => [
        IconTextBtn(
          extent: Get.height * 0.4,
          onTap: () => openUrl(url: 'https://www.49s.co.uk/49s/results'),
          icon: AppIcons.lunchtime,
          title: 'RESULTS',
        ),
        IconTextBtn(
          extent: Get.height * 0.4,
          onTap: () => openUrl(url: 'https://www.youtube.com/@westseatv'),
          icon: AppIcons.youtube,
          title: 'STRATEGIES',
        ),
        feature(image: 'foryou', title: 'FREE VOUCHER'),
        feature(image: 'logo_49s', title: 'PREDICTIONS'),
        IconTextBtn(
          extent: Get.height * 0.4,
          onTap: () {
            Get.toNamed(Routes.generator);
            controller.showInterstitialAd();
          },
          icon: AppIcons.generator,
          title: 'GENERATOR',
        ),
      ];

  InkWell feature({required String image, required String title}) {
    return InkWell(
      onTap: () {
        Get.to(() => const ComingSoon());
        controller.showInterstitialAd();
      },
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
                    image: AssetImage('assets/$image' '.png'),
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

  AppBar appBar() {
    return AppBar(
      title: Row(
        children: [
          IconButton(
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
          const SizedBox(width: 3),
          Text(
            'WEST SEA TV',
            style: appThemeData.textTheme.bodyText1!.copyWith(
              fontSize: 18,
            ),
          ),
        ],
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
                  Get.toNamed(Routes.generator);
                  controller.drawerCtrl.hideDrawer();
                  controller.showInterstitialAd();
                },
                leading: const Icon(
                  AppIcons.generator,
                  color: Colors.grey,
                ),
                title: Text(
                  'Generator',
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
                        'https://play.google.com/store/apps/details?id=com.westseatv.westsea_app&hl=en&gl=US',
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
                      'https://play.google.com/store/apps/details?id=com.westseatv.westsea_app&hl=en&gl=US';
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
