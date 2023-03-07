import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:west_sea/admin/bindings/lunchtime_binding.dart';
import 'package:west_sea/admin/bindings/vouchers_binding.dart';
import 'package:west_sea/admin/screens/lunchtime.dart';
import 'package:west_sea/admin/screens/teatime.dart';
import 'package:west_sea/admin/screens/vouchers.dart';
import 'package:west_sea/app/routes/routes.dart';

import '../../app/ui/theme/apptheme.dart';
import '../bindings/teatime_bindings.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              feature(
                image: 'foryou.png',
                title: '',
                onTap: () => Get.to(
                  () => const AdminVouchersPage(),
                  binding: AdminVouchersBinding(),
                  routeName: Routes.vouchers,
                ),
              ),
              feature(
                image: 'logo_49s.png',
                title: '',
                onTap: () => Get.to(
                  () => const AdminLunchtimePage(),
                  binding: AdminLunchtimeBinding(),
                ),
              ),
              feature(
                image: 'logo_49s.png',
                title: '',
                onTap: () => Get.to(
                  () => const AdminTeatimePage(),
                  binding: AdminTeatimeBinding(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell feature(
      {required String image, required String title, required Callback onTap}) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        height: Get.height * 0.3,
        width: Get.width * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/$image'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                title,
                // ignore: deprecated_member_use
                style: appThemeData.textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
