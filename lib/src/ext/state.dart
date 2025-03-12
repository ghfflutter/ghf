

import 'package:flutter/material.dart';
import 'package:ghf/ghf.dart';

extension StateExt on State {
  //请求接口
  dynamic api(String apiname,{Map<String, dynamic> params = const {}}) async{
    return await Ghf.api(context,apiname,params: params);
  }
  
}