import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_sea/admin/bindings/predictions/lunchtime_binding.dart';
import 'package:west_sea/admin/bindings/predictions/teatime_bindings.dart';
import 'package:west_sea/admin/screens/predictions/lunchtime.dart';
import 'package:west_sea/admin/screens/predictions/teatime.dart';

class AdminPredictionPage extends StatelessWidget {
  const AdminPredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => Get.to(
                    () => const AdminLunchtimePage(),
                    binding: AdminLunchtimeBinding(),
                  ),
                  child: Image.asset('logo_49s.png'),
                ),
                const Text(
                  'LUNCHTIME',
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
                    () => const AdminTeatimePage(),
                    binding: AdminTeatimeBinding(),
                  ),
                  child: Image.asset('logo_49s.png'),
                ),
                const Text(
                  'TEATIME',
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
                () => const AdminLunchtimePage(),
                binding: AdminLunchtimeBinding(),
              ),
              child: Image.asset('logo_49s.png'),
            ),
          ),
          const Text(
            'LUNCHTIME',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => Get.to(
                () => const AdminTeatimePage(),
                binding: AdminTeatimeBinding(),
              ),
              child: Image.asset('logo_49s.png'),
            ),
          ),
          const Text(
            'TEATIME',
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
