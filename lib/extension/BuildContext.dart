import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ghf/net/websock.dart';
import '../net/http.dart';
import '../net/sse.dart';

extension BuildContextExt on BuildContext {
  //获取默认值
  V getVal<K extends Object, V>(K key, V def) {
    return SharedAppData.getValue(this, key, () => def);
  }

  //设置内容
  void setValue<K extends Object, V>(K key, V value) {
    return SharedAppData.setValue(this, key, value);
  }

  //获取语言信息
  Locale getLocale() {
    String? lc = getSharedPreferences().getString("locale");
    final ls = lc!.split('_');
    return Locale.fromSubtags(
        languageCode: ls[0], scriptCode: ls[1], countryCode: ls[2]);
  }

  //设置语言信息
  void setLocale(Locale locale) {
    setValue("local", locale);
    getSharedPreferences().setString("locale", locale.toString());
  }

  //生成接口路径
  @protected
  String buildApiUrl(String name) {
    return getVal('api_host', 'http://127.0.0.1/') + name;
  }

  //设置TOKEN
  void setToken(String token) {
    final st = getVal("token", getSharedPreferences().getString("token"));
    if (token == st) {
      return;
    }
    setValue("token", token);
    getSharedPreferences().setString("token", token);
  }

  //生成请求头部
  @protected
  Map buildApiHeader() {
    return {
      "token": getVal("token", getSharedPreferences().getString("token"))
    };
  }

  @protected
  Map buildPostData(Map? postData) {
    postData ??= {};
    postData['packageinfo'] = getVal('packageinfo', {});
    postData['device'] = getVal('device', {});
    return postData;
  }

  //api接口请求
  Future<dynamic> api(String name, {Map? postData}) {
    return apiSend(buildApiUrl(name),
        postData: buildPostData(postData),
        header: buildApiHeader(), setToken: (t) {
      if (t != null) {
        setToken(t);
      }
    });
  }

  //sseGet
  getSse(String name, Function(String) listen) {
    sseGet(buildApiUrl(name), listen, header: buildApiHeader());
  }

  //ssePost
  postSse(String name, Function(String) listen, {Map? postData}) {
    ssePost(
        buildApiUrl(name) + name, json.encode(buildPostData(postData)), listen,
        header: buildApiHeader());
  }

  //创建websocket
  Future<WebSocket> ws(String name,
      {void Function(dynamic)? onMessage,
      void Function()? onClose,
      Function()? onError}) async {
    return webSocket(buildApiUrl(name),
        onMessage: onMessage, onClose: onClose, onError: onError);
  }

  //获取SharedPreferences
  SharedPreferences getSharedPreferences() {
    return SharedAppData.getValue(
        this,
        "sp",
        () async {
          return await SharedPreferences.getInstance();
        } as SharedAppDataInitCallback<SharedPreferences>);
  }
}
