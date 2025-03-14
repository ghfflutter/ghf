import 'package:flutter/material.dart';
import 'package:ghf/src/utils/gconfig.dart';

import 'package:ghf/src/widget/app_root_widget.dart';

extension StringExt on String {
  
  //显示多语言功能
  String lang(BuildContext context){
    GAppConfig config  = GAppRootWidgetState.of(context).config;
    
    if(config.langMap.isEmpty){
      return this;
    }
    print("${config.currentLocale!.toLanguageTag()} -- ${config.currentLocale!.languageCode} -- ${config.currentLocale!}");
    print(config.langMap);
    if(config.langMap.containsKey(config.currentLocale!.toString())){
      if(config.langMap[config.currentLocale!.toString()]!.containsKey(this)){
        return config.langMap[config.currentLocale!.toString()]![this]!;
      }
      return this;
    }
    if(config.langMap.containsKey(config.currentLocale!.languageCode)){
      if(config.langMap[config.currentLocale!.languageCode]!.containsKey(this)){
        return config.langMap[config.currentLocale!.languageCode]![this]!;
      }
      return this;
    }
    return this;
  }
  
  //显示短时间
  String shortTime(BuildContext context){
    DateTime dt = DateTime.parse(this);
    Duration ms = DateTime.now().difference(dt);
    if(ms.inDays >= 365 ){
      return '${ms.inDays / 365}' + "年".lang(context);
    }else if(ms.inDays >= 30){
      return '${ms.inDays / 30}' + "月".lang(context);
    }else if(ms.inDays >= 7){
      return '${ms.inDays / 7}' + "周".lang(context);
    }else if(ms.inDays >= 1){
      return '${ms.inDays }' + "天".lang(context);
    }else if(ms.inHours >= 1){
      return '${ms.inHours }' + "小时".lang(context); 
    }else if (ms.inMinutes >= 1){
      return '${ms.inMinutes }' + "分钟".lang(context); 
    }else if(ms.inSeconds >= 1){
      return '${ms.inSeconds }' + "秒".lang(context);
    }
    return "";
  }
}