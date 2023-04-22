// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:west_sea/app/ui/pages/home_page/home_page.dart';
// import 'app/bindings/home_binding.dart';
// import 'app/routes/pages.dart';
// import 'app/routes/routes.dart';
// import 'app/ui/theme/apptheme.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   MobileAds.instance.initialize();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.light,
//       theme: appThemeData,
//       initialRoute: Routes.home,
//       initialBinding: HomeBinding(),
//       defaultTransition: Transition.fade,
//       getPages: AppPages.pages,
//       home: const HomePage(),
//     ),
//   );
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea/admin/bindings/mo4mo/admin_auth_binding.dart';
import 'package:west_sea/admin/screens/auth/auth.dart';
import 'common/theme/apptheme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const AdminApp(),
  );
}

class AdminApp extends StatelessWidget {
  const AdminApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      initialBinding: AdminAuthBinding(),
      defaultTransition: Transition.circularReveal,
      home: const AdminAuthPage(),
    );
  }
}
