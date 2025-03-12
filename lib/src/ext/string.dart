import 'package:flutter/material.dart';

import '../utils/location.dart';

extension StringExt on String {
  
  //显示多语言功能
  String location(BuildContext context){
    return GLocalizations.of(context).get(this);
  }
}