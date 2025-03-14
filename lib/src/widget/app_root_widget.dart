
import 'package:flutter/material.dart';
import 'package:ghf/src/utils/gconfig.dart';

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
    widget.config.currentLocale = WidgetsBinding.instance.window.locale;
    // widget.config.currentLocale = View.of(context).platformDispatcher.locale;
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
