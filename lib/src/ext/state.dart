

import 'package:flutter/material.dart';
import 'package:ghf/ghf.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension StateExt on State {
  //请求接口
  dynamic api(String apiname,{Map<String, dynamic> params = const {}}) async{
    return await Ghf.api(context,apiname,params: params);
  }
  //显示toast
  toast(String msg){
    Fluttertoast.showToast(msg: msg);
  }
  
}