// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.blueAccent,
  fontFamily: 'Bebas',
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 72, 111, 179),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Color.fromARGB(255, 72, 111, 179),
  ),
);
