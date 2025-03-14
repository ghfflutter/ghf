import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension BuildContextExt on BuildContext {
  toast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}