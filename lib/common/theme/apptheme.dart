// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:west_sea/common/theme/pallete.dart';

final ThemeData appThemeData = ThemeData.light().copyWith(
  primaryColor: Colors.blueAccent,
  scaffoldBackgroundColor: Pallete.bgColor,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Pallete.bgColor,
  ),
);
