import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:west_sea/common/theme/pallete.dart';

void toast({String? msg, Color? color}) {
  Fluttertoast.showToast(
    msg: msg ?? "This is Center Short Toast",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: color ?? Pallete.bgColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
