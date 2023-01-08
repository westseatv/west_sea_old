// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import 'package:west_sea/app/ui/theme/apptheme.dart';

class IconTextBtn extends StatelessWidget {
  const IconTextBtn({
    Key? key,
    this.title,
    this.extent,
    this.bottomSpace,
    this.icon,
    required this.onTap,
    this.isIcon,
  }) : super(key: key);

  final String? title;
  final double? extent;
  final double? bottomSpace;
  final IconData? icon;
  final bool? isIcon;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        height: extent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon ?? Icons.currency_bitcoin, size: 120),
            const SizedBox(height: 10),
            Text(
              title ?? 'Title',
              style: appThemeData.textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
