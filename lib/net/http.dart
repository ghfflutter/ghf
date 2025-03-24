import 'dart:convert';
import 'dart:io';

Future<dynamic> apiSend(String url,
    {required Function(String?) setToken,
    Map? header,
    dynamic postData}) async {
  if (header == null) {
    header = {"Content-Type": 'application/json'};
  } else {
    header['Content-Type'] = 'application/json';
  }
  final HttpClientResponse rsp = await request("post", url,
      header: header, postData: json.encode(postData));
  if (rsp.statusCode != 200) {
    throw Exception("请求错误");
  }

  setToken(rsp.headers.value("token"));
  final responseBody = await rsp.transform(utf8.decoder).join();
  return json.decode(responseBody);
}

//请求数据
Future<HttpClientResponse> request(String method, String url,
    {Map? header, String? postData}) async {
  final httpClient = HttpClient();
  final uri = Uri.parse(url);
  HttpClientRequest req;
  switch (method.toLowerCase()) {
    case "post":
      req = await httpClient.postUrl(uri);
      break;
    case "delete":
      req = await httpClient.deleteUrl(uri);
      break;
    case "put":
      req = await httpClient.putUrl(uri);
      break;
    default:
      req = await httpClient.getUrl(uri);
      break;
  }
  if (header != null) {
    for (var e in header.entries) {
      req.headers.set(e.key, e.value);
    }
  }
  if (postData != null) {
    req.write(postData);
  }
  // 发送请求并获取响应
  final response = await req.close();
  httpClient.close();
  return response;

  // // 读取响应内容
  // final responseBody = await response.transform(utf8.decoder).join();
  // httpClient.close();
  // return responseBody;
}
