// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import '../../../controllers/predictionsdart_controller.dart';

// class PredictionsPage extends GetView<PredictionsControler> {
//   const PredictionsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PredictionsControler>(
//       initState: (state) {
//         controller.homeCtrl.createBannerAd();
//       },
//       builder: (controller) {
//         return DefaultTabController(
//           length: 3,
//           child: Scaffold(
//             appBar: AppBar(
//               title: const Text('westseatv predictions'),
//               bottom: const TabBar(
//                 tabs: [
//                   Text(
//                     '2 Balls',
//                     style: TextStyle(
//                       //fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     '3 Balls',
//                     style: TextStyle(
//                       //fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Bonuses',
//                     style: TextStyle(
//                       //fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             body: body(),
//             bottomNavigationBar: bannerAd(),
//           ),
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

//   StreamBuilder<DatabaseEvent> body() {
//     return StreamBuilder<DatabaseEvent>(
//       stream: controller.firebaseDb.predictionsStream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return loading();
//         } else {
//           if (snapshot.hasData) {
//             return TabBarView(
//               children: [
//                 controller.firebaseDb.twoBallPredictions.length < 2
//                     ? empty()
//                     : twoBall(),
//                 controller.firebaseDb.threeBallPredictions.length < 2
//                     ? empty()
//                     : threeBall(),
//                 controller.firebaseDb.bonusesPredictions.length < 2
//                     ? empty()
//                     : bonuses(),
//               ],
//             );
//           } else {
//             return error();
//           }
//         }
//       },
//     );
//   }

//   ListView threeBall() {
//     List<dynamic> balls = [];
//     for (var p in controller.firebaseDb.threeBallPredictions) {
//       balls.add(p);
//     }
//     balls.assignAll(balls.reversed.toList());
//     return ListView.builder(
//       itemCount: balls.length - 1,
//       itemBuilder: (context, index) {
//         int j = 0;
//         if (index > 0) {
//           j = 3 * index;
//         }

//         return Column(
//           children: [
//             ListTile(
//               title: Row(
//                 children: [
//                   ball(balls[index]['balls'][0], balls.length - 1, j, 3),
//                   ball(balls[index]['balls'][1], balls.length - 1, j + 1, 3),
//                   ball(balls[index]['balls'][2], balls.length - 1, j + 2, 3),
//                 ],
//               ),
//               subtitle: Column(
//                 children: [
//                   const Divider(),
//                   Text(
//                     '${balls[index]['date']}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(thickness: 10),
//           ],
//         );
//       },
//     );
//   }

//   ListView twoBall() {
//     List<dynamic> balls = [];
//     for (var p in controller.firebaseDb.twoBallPredictions) {
//       balls.add(p);
//     }
//     balls.assignAll(balls.reversed.toList());
//     return ListView.builder(
//       itemCount: balls.length - 1,
//       itemBuilder: (context, index) {
//         int i = 0;
//         if (index > 0) {
//           i = 2 * index;
//         }
//         return Column(
//           children: [
//             ListTile(
//               title: Row(
//                 children: [
//                   ball(balls[index]['balls'][0], balls.length - 1, i, 2),
//                   ball(balls[index]['balls'][1], balls.length - 1, i + 1, 2),
//                 ],
//               ),
//               subtitle: Column(
//                 children: [
//                   const Divider(),
//                   Text(
//                     '${balls[index]['date']}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(thickness: 10),
//           ],
//         );
//       },
//     );
//   }

//   ListView bonuses() {
//     List<dynamic> balls = [];
//     for (var p in controller.firebaseDb.bonusesPredictions) {
//       balls.add(p);
//     }
//     balls.assignAll(balls.reversed.toList());
//     return ListView.builder(
//       itemCount: balls.length - 1,
//       itemBuilder: (context, index) {
//         int i = 0;
//         if (index > 0) {
//           i = 2 * index;
//         }
//         return Column(
//           children: [
//             ListTile(
//               title: Row(
//                 children: [
//                   ball(balls[index]['ball'], balls.length - 1, i, 2),
//                 ],
//               ),
//               subtitle: Column(
//                 children: [
//                   const Divider(),
//                   Text(
//                     '${balls[index]['date']}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(thickness: 10),
//           ],
//         );
//       },
//     );
//   }

//   Center loading() {
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

//   Container ball(String number, int l, int i, int b) {
//     return Container(
//       width: 40,
//       height: 40,
//       alignment: Alignment.center,
//       margin: const EdgeInsets.only(left: 10),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: controller.colors(l, b)[i],
//           width: 8,
//         ),
//         color: Colors.white,
//         shape: BoxShape.circle,
//       ),
//       child: Text(
//         number,
//         style: const TextStyle(
//           fontFamily: 'Tohama',
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
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

//   Center empty() {
//     return const Center(
//       child: Text(
//         'Nor Predictions added yet...',
//         style: TextStyle(
//           color: Color.fromARGB(255, 163, 131, 131),
//           fontWeight: FontWeight.bold,
//           fontSize: 20,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }
