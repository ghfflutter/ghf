part of ghf;
//日志
class ApiLogs {
  static List<ApiLogInfo> logs = [];
  //添加日志
  static void add(ApiLogInfo log) {
    logs.add(log); 
  }
  //清除日志
  static void clear() {
    logs.clear();
  }
  static int get length => logs.length;
}
//日志信息
class ApiLogInfo {
  String url;
  String method;
  String params;
  String response;
  String time;
  ApiLogInfo({
    required this.url,
    required this.method,
    required this.params,
    required this.response,
    required this.time,
  });
}