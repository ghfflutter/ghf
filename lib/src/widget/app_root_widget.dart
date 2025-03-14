
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class GAppRootWidget extends StatefulWidget {
  Widget appWidget;
  GAppConfig config = GAppConfig();
  GAppRootWidget(this.appWidget,this.config,{ Key? key }) : super(key: key);

  @override
  GAppRootWidgetState createState() => GAppRootWidgetState();
}

class GAppRootWidgetState extends State<GAppRootWidget> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return widget.appWidget;
  }
  @override
  void initState() {
    super.initState();
    widget.config.currentLocale = View.of(context).platformDispatcher.locale;
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    if (locales != null && locales.isNotEmpty) {
      setState(() {
        widget.config.currentLocale = locales.first;
      });
    }
     
  }
  static GAppRootWidget of(BuildContext context) {
   return context.findRootAncestorStateOfType<GAppRootWidgetState>()!.widget as GAppRootWidget;
  }

}

//应用配置
class GAppConfig {
  GAppConfig({this.apiHost,this.langMap = const {}});
  //当前语言
  Locale? currentLocale;
  //接口地址
  String? apiHost;
  //包信息
  PackageInfo? packageInfo;
  //多语言配置
  Map<String, Map<String, String>> langMap = {};
}