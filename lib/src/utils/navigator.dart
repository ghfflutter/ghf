import 'package:flutter/material.dart';

class GNavigatorUtil {
  static void push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}