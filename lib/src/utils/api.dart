
import 'dart:io';


class GHttp {
  
  //发送POST请求
  static Future<HttpClientResponse> api(String url,
      {String data = "" }) async {
      final posturl = Uri.parse(url);
      final httpClient = HttpClient();
      final request = await httpClient.postUrl(posturl);
      request.write(data);

      return  request.close();

  }
}
