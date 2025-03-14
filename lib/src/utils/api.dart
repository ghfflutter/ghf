
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghf/src/ext/string.dart';
import 'package:ghf/src/utils/gconfig.dart';
import 'package:ghf/src/widget/app_root_widget.dart';

class GHttp {
  
  //请求接口
  static Future<dynamic> api(BuildContext context,String apiname,{Map<String, dynamic> params = const {}}) async{
      GAppConfig config  = GAppRootWidgetState.of(context).config;
      final posturl = Uri.parse(config.apiHost! + apiname);
      final httpClient = HttpClient();
      params['app'] = config.packageInfo!.packageName;
      params['app_ver'] = config.packageInfo!.version;
      params['app_ver_num'] = config.packageInfo!.buildNumber;
      params['store'] = config.packageInfo!.installerStore;
      params['signature'] = config.packageInfo!.buildSignature;
      final request = await httpClient.postUrl(posturl);
      request.write(json.encode(params));
      HttpClientResponse resp = await request.close();
      if (resp.statusCode == 200) {
        String respData = await resp.transform(utf8.decoder).join();
        return Future.value(json.decode(respData));
      }else{
        Fluttertoast.showToast(
          msg: "请求失败".lang(context),
        );
      }
  }
}
