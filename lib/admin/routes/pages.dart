import 'package:get/get.dart';
import 'package:west_sea/admin/bindings/auth_binding.dart';
import 'package:west_sea/admin/screens/auth.dart';
import 'package:west_sea/admin/screens/home_page.dart';

import 'names.dart';

abstract class AdmniAppPages {
  static final pages = [
    GetPage(
      name: AdminRoutes.auth,
      page: () => const AuthPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AdminRoutes.home,
      page: () => const AdminHomePage(),
    ),
  ];
}
