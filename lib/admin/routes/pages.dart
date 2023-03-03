import 'package:get/get.dart';
import 'package:west_sea/admin/bindings/auth_binding.dart';
import 'package:west_sea/admin/bindings/vouchers_binding.dart';
import 'package:west_sea/admin/screens/auth.dart';
import 'package:west_sea/admin/screens/home_page.dart';
import 'package:west_sea/admin/screens/vouchers.dart';

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
    GetPage(
      name: AdminRoutes.vouchers,
      page: () => const AdminVouchersPage(),
      binding: AdminVouchersBinding(),
    ),
    // GetPage(
    //   name: AdminRoutes.predictions,
    //   page: () => const AdminPredictionsPage(),
    //   binding: AdminPredictionsBinding(),
    // ),
  ];
}
