import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../controllers/vouchers_ctrl.dart';

class AdminVouchersPage extends GetView<VouchersController> {
  const AdminVouchersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vouchers')),
      body: body(),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add, size: 30),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return dialog();
            },
          );
        },
      ),
    );
  }

  AlertDialog dialog() {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 13, 34, 51),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            controller: controller.vTxtCtrl,
            decoration: const InputDecoration(
              label: Text('voucher'),
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.fTxtCtrl,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            decoration: const InputDecoration(
              label: Text('fake'),
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.cTxtCtrl,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            decoration: const InputDecoration(
              label: Text('claim code'),
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        MaterialButton(
          color: Colors.red,
          child: const Text(
            'Cancel',
          ),
          onPressed: () {
            controller.vTxtCtrl.clear();
            controller.fTxtCtrl.clear();
            controller.cTxtCtrl.clear();
            navigator!.pop();
          },
        ),
        MaterialButton(
          color: Colors.green,
          child: const Text(
            'Add',
          ),
          onPressed: () {
            if (controller.vTxtCtrl.text.isNotEmpty &&
                controller.fTxtCtrl.text.isNotEmpty &&
                controller.cTxtCtrl.text.isNotEmpty) {
              controller.firebaseDb.onAddVoucher(
                v: controller.vTxtCtrl.text.trim(),
                f: controller.fTxtCtrl.text.trim(),
                c: controller.cTxtCtrl.text.trim(),
              );
            } else {
              Get.showSnackbar(
                const GetSnackBar(
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  message: 'All feild must be filled',
                ),
              );
            }
          },
        ),
      ],
    );
  }

  StreamBuilder<DatabaseEvent> body() {
    return StreamBuilder<DatabaseEvent>(
      stream: controller.firebaseDb.voucherStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitimg();
        } else {
          if (snapshot.hasData) {
            List<dynamic>? data = snapshot.data!.snapshot.value as List?;

            return data!.length > 1 ? vouchers(data) : noVouchers();
          } else {
            return error();
          }
        }
      },
    );
  }

  Center error() {
    return const Center(
      child: Text(
        'Something went wrong try to restart this app',
        style: TextStyle(
          color: Color.fromARGB(255, 163, 131, 131),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Center noVouchers() {
    return const Center(
      child: Text(
        'Out of Vouchers they will be added soon...',
        style: TextStyle(
          color: Color.fromARGB(255, 163, 131, 131),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  ListView vouchers(List<dynamic> data) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: data.length - 1,
      itemBuilder: (context, index) {
        return voucherTile(
          voucher: '${data[index + 1]['v']}',
          code: '${data[index + 1]['c']}',
          status: data[index + 1]['t'],
          onDelete: () {
            controller.firebaseDb.onDeleteVouchers(index: index + 1);
          },
        );
      },
    );
  }

  Center waitimg() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            strokeWidth: 5,
          ),
          SizedBox(height: 20),
          Text(
            'Loading...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget voucherTile({
    required String voucher,
    required String code,
    required int status,
    required Callback onDelete,
  }) {
    bool claimed = status == 0;
    return ListTile(
      tileColor: Colors.blueAccent,
      title: Text(voucher),
      subtitle: Text('Code: $code'),
      trailing: IconButton(
        onPressed: onDelete,
        icon: Icon(
          Icons.delete,
          color: claimed ? Colors.red : Colors.green,
          size: 30,
        ),
      ),
    );
  }
}
