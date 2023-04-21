// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../theme/pallete.dart';
import 'logo.dart';

class Body extends StatelessWidget {
  final Widget child;
  final Widget? floating;
  const Body({
    Key? key,
    required this.child,
    this.floating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Logo(),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          color: Pallete.grayshColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        child: child,
      ),
      floatingActionButton: floating,
    );
  }
}
