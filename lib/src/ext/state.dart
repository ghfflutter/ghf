

import 'package:flutter/material.dart';
import 'package:ghf/ghf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/navigator.dart';

extension StateExt on State {
  //请求接口
  dynamic api(String apiname,{Map<String, dynamic> params = const {}}) async{
    return await Ghf.api(context,apiname,params: params);
  }
  //显示toast
  toast(String msg){
    Fluttertoast.showToast(msg: msg);
  }
  //跳转页面
  push(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
  
}