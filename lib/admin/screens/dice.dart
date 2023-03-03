// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/dice_controller.dart';

// class AdminDicePage extends GetView<AdminDiceController> {
//   const AdminDicePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<DatabaseEvent>(
//         stream: controller.firebaseDb.stream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return loading();
//           } else {
//             if (snapshot.hasData) {
//               List<dynamic> rewards = snapshot.data?.snapshot.value as List;
//               return Scaffold(
//                 appBar: AppBar(title: const Text('Rewards')),
//                 body: rewards.length > 1 ? rewardsList(rewards) : ranOut(),
//                 floatingActionButton: add(context),
//               );
//             } else {
//               return error();
//             }
//           }
//         });
//   }

//   Scaffold loading() {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(
//           strokeWidth: 15,
//           color: Colors.blue,
//           backgroundColor: Colors.purple,
//         ),
//       ),
//     );
//   }

//   ListView rewardsList(List<dynamic> rewards) {
//     return ListView.builder(
//       itemCount: rewards.length - 1,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(
//               '${rewards[index + 1]['name']} ${rewards[index + 1]['cost']}D'),
//           subtitle: Text(
//             '${rewards[index + 1]['value']}',
//             style: const TextStyle(fontFamily: 'Tahoma'),
//           ),
//           trailing: IconButton(
//             onPressed: () {
//               controller.firebaseDb.onDeleteReward(index + 1);
//             },
//             icon: Icon(
//               Icons.delete,
//               size: 32,
//               color: rewards[index + 1]['isClaimed'] == 1
//                   ? Colors.green
//                   : Colors.red,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Scaffold error() {
//     return const Scaffold(
//       body: Center(
//         child: Text('Having error'),
//       ),
//     );
//   }

//   FloatingActionButton add(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text('Add Reward'),
//               content: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: controller.nameTxtCtrl,
//                       style:
//                           const TextStyle(fontSize: 22, fontFamily: 'Tahoma'),
//                       decoration: const InputDecoration(
//                         hintText: 'Name',
//                         hintStyle: TextStyle(fontSize: 22),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: controller.valueTxtCtrl,
//                       style:
//                           const TextStyle(fontSize: 22, fontFamily: 'Tahoma'),
//                       decoration: const InputDecoration(
//                         hintText: 'Value',
//                         hintStyle: TextStyle(fontSize: 22),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: controller.amountTxtCtrl,
//                       style:
//                           const TextStyle(fontSize: 22, fontFamily: 'Tahoma'),
//                       decoration: const InputDecoration(
//                         hintText: 'Amount',
//                         hintStyle: TextStyle(fontSize: 22),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: controller.descTxtCtrl,
//                       maxLines: null,
//                       style:
//                           const TextStyle(fontSize: 22, fontFamily: 'Tahoma'),
//                       decoration: const InputDecoration(
//                         hintText: 'Description',
//                         hintStyle: TextStyle(fontSize: 22),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//               actions: [
//                 ElevatedButton(
//                   onPressed: () {
//                     controller.amountTxtCtrl.clear();
//                     controller.descTxtCtrl.clear();
//                     controller.nameTxtCtrl.clear();
//                     controller.valueTxtCtrl.clear();
//                     navigator!.pop();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                   ),
//                   child: const Text(
//                     'Close',
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (controller.nameTxtCtrl.text.isNotEmpty &&
//                         controller.valueTxtCtrl.text.isNotEmpty &&
//                         controller.amountTxtCtrl.text.isNotEmpty &&
//                         controller.descTxtCtrl.text.isNotEmpty) {
//                       int cost = int.parse(controller.amountTxtCtrl.text);
//                       controller.firebaseDb.onAddReward(
//                         name: controller.nameTxtCtrl.text,
//                         value: controller.valueTxtCtrl.text,
//                         cost: cost,
//                         desc: controller.descTxtCtrl.text,
//                       );
//                       controller.amountTxtCtrl.clear();
//                       controller.descTxtCtrl.clear();
//                       controller.nameTxtCtrl.clear();
//                       controller.valueTxtCtrl.clear();
//                       Get.showSnackbar(
//                         const GetSnackBar(
//                           duration: Duration(seconds: 2),
//                           message: 'Reward Added',
//                           backgroundColor: Colors.green,
//                         ),
//                       );
//                     } else {
//                       Get.showSnackbar(
//                         const GetSnackBar(
//                           duration: Duration(seconds: 2),
//                           message: 'Fill all fields',
//                           backgroundColor: Colors.red,
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                   ),
//                   child: const Text(
//                     'Add',
//                     style: TextStyle(fontSize: 24),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       child: const Icon(
//         Icons.add,
//         size: 30,
//       ),
//     );
//   }

//   Center ranOut() {
//     return const Center(
//       child: Text(
//         'No rewards available yet...they\'ll be available soon',
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }
