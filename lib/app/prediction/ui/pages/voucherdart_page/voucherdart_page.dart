// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import '../../../controllers/voucherdart_controller.dart';

// class VoucherDartPage extends GetView<VoucherDartController> {
//   const VoucherDartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<VoucherDartController>(
//       initState: (state) {
//         controller.homeCtrl.createBannerAd();
//       },
//       builder: (contoller) {
//         return Scaffold(
//           appBar: AppBar(title: const Text('Vouchers')),
//           body: body(context),
//           bottomNavigationBar: bannerAd(),
//         );
//       },
//     );
//   }

//   bannerAd() {
//     return controller.homeCtrl.homeBannerAd != null
//         ? StatefulBuilder(
//             builder: (context, setState) => SizedBox(
//               height: AdSize.banner.height.toDouble(),
//               width: AdSize.banner.width.toDouble(),
//               child: AdWidget(
//                 ad: controller.homeCtrl.homeBannerAd!,
//               ),
//             ),
//           )
//         : null;
//   }

//   StreamBuilder<DatabaseEvent> body(BuildContext context) {
//     return StreamBuilder<DatabaseEvent>(
//       stream: controller.firebaseDb.voucherStream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return waitimg();
//         } else {
//           if (snapshot.hasData) {
//             List<dynamic>? data = snapshot.data!.snapshot.value as List?;

//             return data!.length > 1 ? vouchers(data, context) : noVouchers();
//           } else {
//             return error();
//           }
//         }
//       },
//     );
//   }

//   Center error() {
//     return const Center(
//       child: Text(
//         'Something went wrong try to restart this app',
//         style: TextStyle(
//           color: Color.fromARGB(255, 163, 131, 131),
//           fontWeight: FontWeight.bold,
//           fontSize: 20,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   Center noVouchers() {
//     return const Center(
//       child: Text(
//         'Out of Vouchers they will be added soon...',
//         style: TextStyle(
//           color: Color.fromARGB(255, 163, 131, 131),
//           fontWeight: FontWeight.bold,
//           fontSize: 20,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   ListView vouchers(List<dynamic> data, BuildContext context) {
//     return ListView.separated(
//       separatorBuilder: (context, index) => const SizedBox(height: 20),
//       itemCount: data.length - 1,
//       itemBuilder: (context, index) {
//         return voucherTile(
//           voucher: '${data[index + 1]['f']}',
//           status: data[index + 1]['t'],
//           onClaim: () {
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 content: claiming(data[index + 1]['v']),
//                 backgroundColor: const Color.fromARGB(255, 21, 63, 97),
//                 actions: [
//                   Obx(
//                     () => Visibility(
//                       visible: controller.claimed.isFalse,
//                       child: MaterialButton(
//                         color: Colors.green,
//                         child: const Text('Claim Now'),
//                         onPressed: () {
//                           controller.isClaiming(true);
//                           if (data[index + 1]['c'] ==
//                               controller.txtCtrl.text.trim()) {
//                             controller.firebaseDb.claiming(index + 1);
//                             controller.claimed(true);
//                           } else {
//                             controller.claimed(false);
//                             controller.txtCtrl.clear();
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                   MaterialButton(
//                     color: Colors.red,
//                     child: const Text('Close'),
//                     onPressed: () {
//                       controller.txtCtrl.clear();
//                       controller.isClaiming(false);
//                       controller.claimed(false);
//                       navigator!.pop();
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Center waitimg() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: const [
//           CircularProgressIndicator(
//             strokeWidth: 5,
//           ),
//           SizedBox(height: 20),
//           Text(
//             'Loading...',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//             textAlign: TextAlign.center,
//           )
//         ],
//       ),
//     );
//   }

//   Widget voucherTile(
//       {required String voucher,
//       required int status,
//       required Callback onClaim}) {
//     bool claimed = status == 0;
//     return ListTile(
//       tileColor: Colors.blueAccent,
//       title: Text(voucher),
//       trailing: MaterialButton(
//         color: Colors.green,
//         disabledColor: Colors.red,
//         disabledTextColor: Colors.black,
//         onPressed: claimed ? null : onClaim,
//         child: claimed ? const Text('Claimed') : const Text('Claim'),
//       ),
//     );
//   }

//   Widget claiming(String v) {
//     return Obx(
//       () => Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: controller.txtCtrl,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//             decoration: const InputDecoration(
//               label: Text('Claim Code'),
//               labelStyle: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: Colors.black,
//                   width: 10,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Visibility(
//             visible: controller.isClaiming.value,
//             child: controller.claimed.value
//                 ? const Text(
//                     'Successfully claimed!!! below is your claimed betting voucher, CLICK COPY AND KEEP IT SAFE',
//                     style: TextStyle(
//                       color: Colors.green,
//                     ),
//                     textAlign: TextAlign.center,
//                   )
//                 : const Text(
//                     'incorrect claim code try again',
//                     style: TextStyle(
//                       color: Colors.red,
//                     ),
//                   ),
//           ),
//           Visibility(
//             visible: controller.claimed.isTrue,
//             child: ListTile(
//               tileColor: Colors.blue,
//               title: Text(
//                 v,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               trailing: IconButton(
//                 icon: const Icon(Icons.copy, color: Colors.white),
//                 onPressed: () => Clipboard.setData(ClipboardData(text: v)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
