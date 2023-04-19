import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:west_sea/admin/bindings/predictions/lunchtime_binding.dart';
import 'package:west_sea/admin/bindings/mo4mo/mo4mo.dart';
import 'package:west_sea/admin/screens/mo4mo/admin_mo4mo_view.dart';
import 'package:west_sea/admin/screens/predictions/lunchtime.dart';
import 'package:west_sea/admin/screens/predictions/teatime.dart';
import '../bindings/predictions/teatime_bindings.dart';

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
                image: 'mo4mo.png',
                title: 'MO4MO',
                onTap: () => Get.to(
                  () => const AdminMo4moPage(),
                  binding: AdminMom4moBinding(),
                ),
              ),
              feature(
                image: 'logo_49s.png',
                title: 'LUNCHTIME',
                onTap: () => Get.to(
                  () => const AdminLunchtimePage(),
                  binding: AdminLunchtimeBinding(),
                ),
              ),
              feature(
                image: 'logo_49s.png',
                title: 'TEATIME',
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
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/$image'),
                  ),
                ),
              ),
            ),
            Text(
              title,
            ),
          ],
        ),
      ),
    );
  }
}
