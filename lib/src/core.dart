import 'dart:async';

import 'package:flutter/material.dart';
import 'utils/SharedPreferences.dart';
import 'utils/Location.dart';

class GBase {
  static bool _isDebug = true;
  static String _apihost = "";
  static String _aesKey = "";

  //运行程序
  static run(
      {required Widget app,
      required String host,
      required String aeskey,
      required bool debug}) {
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await AppSharedPreferences.init();
      LangData.loadLangAssets();
      _apihost = host;
      _aesKey = aeskey;
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
}
