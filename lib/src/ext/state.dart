

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ghf/src/utils/api.dart';
import 'package:ghf/src/utils/store.dart';
import '../utils/navigator.dart';


extension StateExt on State {
  //请求接口
  Future<dynamic> api(String apiname,{Map<String, dynamic> params = const {}}) async{
    
    return await GHttp.api(context,apiname,params: params);
  }
  //显示toast
  toast(String msg){
    Fluttertoast.showToast(msg: msg);
  }
  //跳转页面
  Future<T?> push<T extends Object?>(Widget page) {
    return GNavigatorUtil.push(context, page);
  }
  //返回上一页
  void pop<T extends Object?>(BuildContext context, [ T? result ]){
    GNavigatorUtil.pop(context,result);
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