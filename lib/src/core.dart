import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ghf/ghf.dart';
import 'package:ghf/src/utils/gconfig.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'utils/store.dart';
import 'widget/app_root_widget.dart';

//启动应用
void appRun(Widget app,{GAppConfig? config}) async {
  WidgetsFlutterBinding.ensureInitialized();
  config ??= GAppConfig();
  await GStore.init();
  PackageInfo.fromPlatform().then((value) {
    config?.packageInfo = value;
  });
  runApp(GAppRootWidget(app,config));
}
