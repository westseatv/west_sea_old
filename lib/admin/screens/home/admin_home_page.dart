import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bindings/mo4mo/admin_mo4mo.dart';
import '../mo4mo/home/admin_mo4mo_view.dart';
import '../predictions/admin_predictions.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (p0, p1) {
          return p1.maxWidth > 550 ? row() : column();
        },
      ),
    );
  }

  Widget row() {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => Get.to(
                    () => AdminMo4moPage(),
                    binding: AdminMom4moBinding(),
                  ),
                  child: Image.asset('mo4mo.png'),
                ),
                const Text(
                  'MO4MO',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => Get.to(
                    () => const AdminPredictionPage(),
                  ),
                  child: Image.asset('logo_49s.png'),
                ),
                const Text(
                  'PREDICTIONS',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget column() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => Get.to(
                () => AdminMo4moPage(),
                binding: AdminMom4moBinding(),
              ),
              child: Image.asset('mo4mo.png'),
            ),
          ),
          const Text(
            'MO4MO',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => Get.to(
                () => const AdminPredictionPage(),
              ),
              child: Image.asset('logo_49s.png'),
            ),
          ),
          const Text(
            'PREDICTIONS',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
