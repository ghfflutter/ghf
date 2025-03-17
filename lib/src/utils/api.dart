import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghf/src/ext/string.dart';
import 'package:ghf/src/utils/gconfig.dart';
import 'package:ghf/src/widget/app_root_widget.dart';

class GHttp {
  //请求接口
  static Future<dynamic> api(BuildContext context, String apiname,
      {Map<String, dynamic> params = const {}}) async {
    try {
      GAppConfig config = GAppRootWidget.of(context).config;
      final posturl = Uri.parse(config.apiHost! + apiname);
      final httpClient = HttpClient();
      Map<String, dynamic> param = {};
      params.forEach((key, value) {
        param[key] = value;
      });
      param['platform_sdk_ver'] = Platform.version;
      param['platform_ver'] = Platform.operatingSystemVersion;
      param['os'] = Platform.operatingSystem;
      param['platform_local'] = Platform.localeName;

      param['app'] = config.packageInfo!.packageName;
      param['app_ver'] = config.packageInfo!.version;
      param['app_ver_num'] = config.packageInfo!.buildNumber;
      param['store'] = config.packageInfo!.installerStore;
      param['signature'] = config.packageInfo!.buildSignature;
      print(param);
      String reqData = json.encode(param);
      final request = await httpClient.postUrl(posturl);
      request.write(reqData);
      print("API $reqData");
      HttpClientResponse resp = await request.close();
      if (resp.statusCode == 200) {
        String respData = await resp.transform(utf8.decoder).join();
        return Future.value(json.decode(respData));
      } else {
        Fluttertoast.showToast(
          msg: "请求失败".lang(context),
        );
      }
    }  on SocketException catch (e)  {
      Fluttertoast.showToast(
        msg: "请求失败".lang(context),
      );
    }
    return Future.value(null);
  }
}
