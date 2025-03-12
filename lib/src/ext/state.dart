

import 'package:flutter/material.dart';
import 'package:ghf/ghf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/navigator.dart';

extension StateExt on State {
  //请求接口
  Future<dynamic> api(String apiname,{Map<String, dynamic> params = const {}}) async{
    return await Ghf.api(context,apiname,params: params);
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
  
}