import 'package:flutter/material.dart';

class GNavigatorUtil {
  static Future<T?> push<T extends Object?>(BuildContext context, Widget page) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
  static Future<T?> pushReplacement<T extends Object?>(BuildContext context, Widget page) {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }
  static Future<T?> pushNamed<T extends Object?>(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.pushNamed(context, routeName, arguments: arguments); 
  }

  static void pop<T extends Object?>(BuildContext context, [ T? result ]) {
    Navigator.pop(context, result);
  }
}