import 'package:flutter/material.dart';

import '../utils/location.dart';

extension StringExt on String {
  
  //显示多语言功能
  String location(BuildContext context){
    return GLocalizations.of(context).get(this);
  }

  //显示短时间
  String shortTime(BuildContext context){
    DateTime dt = DateTime.parse(this);
    Duration ms = DateTime.now().difference(dt);
    if(ms.inDays >= 365 ){
      return '${ms.inDays / 365}' + "年".location(context);
    }else if(ms.inDays >= 30){
      return '${ms.inDays / 30}' + "月".location(context);
    }else if(ms.inDays >= 7){
      return '${ms.inDays / 7}' + "周".location(context);
    }else if(ms.inDays >= 1){
      return '${ms.inDays }' + "天".location(context);
    }else if(ms.inHours >= 1){
      return '${ms.inHours }' + "小时".location(context); 
    }else if (ms.inMinutes >= 1){
      return '${ms.inMinutes }' + "分钟".location(context); 
    }else if(ms.inSeconds >= 1){
      return '${ms.inSeconds }' + "秒".location(context);
    }
    return "";
  }
}