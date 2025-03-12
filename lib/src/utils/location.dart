

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final List<String> _langAssets = [
  "zh","en","zh_TW","ja","ko","fr","de","es","it","pt","ru","ar","hi","bn","tr","vi","th","id","ms","ph","tl","fil","tlh"
  "zh_CN",
  "en_US", 
  "zh_TW",
  "ja_JP",
  "ko_KR",
  "fr_FR",
  "de_DE",
  "es_ES",
  "it_IT",
  "pt_PT",
  "ru_RU",
  "ar_AR",
  "hi_IN",
  "bn_BD",
  "tr_TR",
  "vi_VN",
  "th_TH",
  "id_ID",
  "ms_MY",
  "ph_PH",
  "tl_PH",
  "fil_PH",
  "tlh_PH",
  "tlh_XX",
  "tlh_PI",
  "tlh_LI",
  "tlh_UM",
  "tlh_ER",
  "tlh_ET", 
  "tlh_EE", 
  "tlh_EO",
  "tlh_KR"
];
//多语言数据配置
class GLocationLangMap {
    //单例模式  
    static  GLocationLangMap? _instance;
    factory GLocationLangMap() {
      if(_instance == null){
        _instance = GLocationLangMap._internal();
        _instance!._langMap = {};
        _instance!.loadJson();
      }
      
      return _instance!;
    }
    GLocationLangMap._internal();

    Map<String, Map<String, String>> _langMap = {};
    //加载json数据
    loadJson(){
        _langAssets.map((item){
          rootBundle.loadString(item).then((value){
            json.decode(value).forEach((key, value) {
              if(_langMap.containsKey(item)){
                _langMap[item]![key] = value;
              }else{
                _langMap[item] = {key:value};
              }
            });
          });
        });
    }
    //获取多语言信息
    String get(String key,Locale locale) {
      if(_langMap.containsKey(locale.toLanguageTag())){
        if(_langMap[locale.toLanguageTag()]!.containsKey(key)){
          return _langMap[locale.toLanguageTag()]![key]!;
        }
      }else if(_langMap.containsKey(locale.languageCode)){
        if(_langMap[locale.toLanguageTag()]!.containsKey(key)){
          return _langMap[locale.toLanguageTag()]![key]!;
        }
      }
      return key;
    }
} 

class GLocalizations {
  static LocalizationsDelegate<GLocalizations> delegate = _MyDelegate();

  GLocalizations(this.locale);

  final Locale locale;

  static Future<GLocalizations> load(Locale locale) {
    return SynchronousFuture<GLocalizations>(GLocalizations(locale));
  }

  static GLocalizations of(BuildContext context) {
    return Localizations.of<GLocalizations>(context, GLocalizations)!;
  }

  String get(String key) {
    return GLocationLangMap().get(key, locale); 
  }
}
// continuing from previous example...
class _MyDelegate extends LocalizationsDelegate<GLocalizations> {
  @override
  Future<GLocalizations> load(Locale locale) => GLocalizations.load(locale);

  @override
  bool isSupported(Locale locale) {
    // in a real implementation this would only return true for
    // locales that are definitely supported.
    return true;
  }

  @override
  bool shouldReload(_MyDelegate old) => false;
}