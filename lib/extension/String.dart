import 'package:flutter/widgets.dart';
import 'package:ghf/extension/BuildContext.dart';

extension StringExt on String {
  //多语言输出
  String local(BuildContext context, {Map? args}) {
    Locale lc = context.getLocale();
    Map<String, Map<String, String>> langmap = context.getVal("lang_map", {});
    String lname = lc.toString();
    if (langmap.isEmpty) {
      if (args != null) {
        return this.format(args);
      }
      return this;
    }
    if (langmap.containsKey(lname)) {
      if (langmap[lname]!.containsKey(this)) {
        if (args != null) {
          return langmap[lname]![this]!.format(args);
        }
        return langmap[lname]![this]!;
      }
      if (args != null) {
        return this.format(args);
      }
      return this;
    }
    lname = lc.languageCode;
    if (langmap.containsKey(lname)) {
      if (langmap[lname]!.containsKey(this)) {
        if (args != null) {
          return langmap[lname]![this]!.format(args);
        }
        return langmap[lname]![this]!;
      }
    }
    if (args != null) {
      return format(args);
    }
    return this;
  }

  //格式化输出
  String format(Map args) {
    String aa = this;
    for (var e in args.entries) {
      aa = aa.replaceAll('\${${e.key}}', e.value);
    }
    return aa;
  }
}
