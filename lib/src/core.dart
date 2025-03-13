import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghf/ghf.dart';
import 'package:ghf/src/utils/api.dart';
import 'package:ghf/src/utils/api_logs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'utils/store.dart';
import 'utils/Location.dart';

class Ghf {
  static bool _isDebug = true;
  static String _apihost = "";
  static PackageInfo? _packageInfo;

  static String getHost() {
   return _apihost; 
  }
  static setHost(String host){
    _apihost = host;
  }
  //运行程序
  static run({required Widget app, required String host, required bool debug}) {
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      GStore();
      _packageInfo = await PackageInfo.fromPlatform();
      _apihost = host;
      _isDebug = debug;
      runApp(app);
    }, (error, stackTrace) {
      // 异常处理函数
      print('捕获到异常: $error');
      print('堆栈跟踪: $stackTrace');
    });
  }

  // 是否是debug模式
  static bool isDebug() {
    return _isDebug;
  }

  //展示debug按钮
  static Widget devbutton(BuildContext context) {
    if (!_isDebug) {
      return Container();
    }
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/devtool');
      },
      tooltip: '开发设置',
      child: const Icon(Icons.developer_board),
    );
  }
  //显示toast
  static toast(String msg){
    Fluttertoast.showToast(msg: msg);
  }
  //api请求
  static Future<dynamic> api(BuildContext context, String apiname,
      {Map<String, dynamic> params = const {}}) async {
    params['app'] = _packageInfo!.packageName;
    params['version'] = _packageInfo!.version;
    params['build'] = _packageInfo!.buildNumber;
    String url = "$_apihost/$apiname";
    String postData = json.encode(params);
    HttpClientResponse resp = await GHttp.api(url, data: postData);

    if (resp.statusCode == 200) {
      String respData = await resp.transform(utf8.decoder).join();
      if (_isDebug) {
        ApiLogs.add(ApiLogInfo(
          url: url,
          method: 'POST',
          params: postData,
          response: respData,
          time: DateTime.now().toString(),
        ));
      }
      return json.decode(respData);
    } else {
      if (_isDebug) {
        ApiLogs.add(ApiLogInfo(
          url: url,
          method: 'POST',
          params: postData,
          response: "",
          time: DateTime.now().toString(),
        ));
      }
      Fluttertoast.showToast(
        msg: "请求失败".lang(context),
      );
      return null;
    }
  }

  // 多语言相关 ----------------------------------------------
  // 获取多语言配置的 delegate
  static LocalizationsDelegate getLocalizationsDelegate() {
    return GLocalizations.delegate;
  }

  // 保持数据相关 ----------------------------------------------
  //获取字符串
  String getStore(String key, {String def = ''}) {
    return GStore().get(key, def: def);
  }

  //获取bool值
  bool getStoreBool(String key, {bool def = false}) {
    return GStore().getBool(key, def: def);
  }

  //获取int值
  int getStoreInt(String key, {int def = 0}) {
    return GStore().getInt(key, def: def);
  }

  //设置字符串
  setStore(String key, String value) {
    GStore().set(key, value);
  }

  //设置int值
  setStoreInt(String key, int value) {
    GStore().setInt(key, value);
  }

  //设置bool值
  setStoreBool(String key, bool value) {
    GStore().setBool(key, value);
  }

  //清空数据
  clearStore() {
    GStore().clear();
  }

  //删除数据
  removeStore(String key) {
    GStore().remove(key);
  }
}
