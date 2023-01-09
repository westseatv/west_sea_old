import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/voucherdart_controller.dart';

class VoucherDartPage extends GetView<VoucherDartController> {
  const VoucherDartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoucherDartController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Betting Vouchers',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: List.generate(
              20,
              (index) =>  ListTile(
                title: const Text(
                  '2937373723737454545',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '06/01/23 18:56',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Divider(thickness: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
