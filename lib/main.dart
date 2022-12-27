import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea/app/bindings/home_binding.dart';
import 'package:west_sea/app/ui/pages/home_page/home_page.dart';
import 'app/routes/pages.dart';
import 'app/routes/routes.dart';
import 'app/ui/theme/apptheme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: appThemeData,
      initialRoute: Routes.home,
      initialBinding: HomeBinding(),
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
      home: const HomePage(),
    ),
  );
}
