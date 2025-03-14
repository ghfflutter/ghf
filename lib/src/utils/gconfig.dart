
//应用配置
import 'dart:ui';

import 'package:package_info_plus/package_info_plus.dart';

class GAppConfig {
  GAppConfig({this.apiHost,this.packageInfo,this.langMap = const {}});
  //当前语言
  Locale? currentLocale;
  //接口地址
  String? apiHost;
  //包信息
  PackageInfo? packageInfo;
  //多语言配置
  Map<String, Map<String, String>> langMap = {};
}