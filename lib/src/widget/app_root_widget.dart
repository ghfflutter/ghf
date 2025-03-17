
import 'package:flutter/material.dart';
import 'package:ghf/src/utils/gconfig.dart';
import 'package:ghf/src/utils/store.dart';

class GAppRootWidget extends InheritedWidget with WidgetsBindingObserver {
  GAppConfig config;
  GAppRootWidget(Widget child,this.config,{ Key? key }) : super(key: key,child: child);

  
  @override
  bool updateShouldNotify(covariant GAppRootWidget oldWidget) {
    return oldWidget.config != config;
  }
  static GAppRootWidget of(BuildContext context) {
   return context.dependOnInheritedWidgetOfExactType<GAppRootWidget>() as GAppRootWidget;
  }
   @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    if (locales != null && locales.isNotEmpty) {
      config.currentLocale = locales.first;
    }
  }
  void initState() {
    print("isFirst ${GStore().getBool("isFirst",def :false)}");
    GStore().setBool("isFirst", true);
    print("isFirst ${GStore().getBool("isFirst",def :false)}");
    config.currentLocale = WidgetsBinding.instance.window.locale;
    // widget.config.currentLocale = View.of(context).platformDispatcher.locale;
    WidgetsBinding.instance.addObserver(this);
  }
}

