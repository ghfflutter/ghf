import 'package:shared_preferences/shared_preferences.dart';

class GStore {
  //单例  
  static final GStore _instance = GStore._internal();
  factory GStore() => _instance;
  
  GStore._internal();
  SharedPreferences? _sp;
  static init() async {
    _instance._sp = await SharedPreferences.getInstance();
  }
  String get(String key, {String def = ''}) {
    return _sp?.getString(key) ?? def;
  }

  set(String key, String value) {
    _sp?.setString(key, value);
  }
  int getInt(String key, {int def = 0}) {
    return _sp?.getInt(key)?? def; 
  }
  setInt(String key, int value) {
    _sp?.setInt(key, value);
  }
  bool getBool(String key, {bool def = false}) {
    return _sp?.getBool(key)?? def; 
  }
  setBool(String key, bool value) {
    _sp?.setBool(key, value);
  }
  clear() {
    _sp?.clear();
  }
  remove(String key) {
    _sp?.remove(key);
  }

}