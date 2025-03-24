import 'dart:convert';
import 'dart:io';

void sseGet(String url, Function(String) listen, {Map? header}) {
  HttpClient().getUrl(Uri.parse(url)).then((r) {
    if (header != null) {
      for (var e in header.entries) {
        r.headers.set(e.key, e.value);
      }
    }
    r.close().then((res) {
      res.transform(utf8.decoder).listen((event) {
        if (event.startsWith("data: ")) {
          listen(event.substring(6).trim());
        }
      });
    });
  });
}

void ssePost(String url, String data, Function(String) listen, {Map? header}) {
  HttpClient().postUrl(Uri.parse(url)).then((r) {
    if (header != null) {
      for (var e in header.entries) {
        r.headers.set(e.key, e.value);
      }
    }
    r.write(data);
    r.close().then((res) {
      res.transform(utf8.decoder).listen((event) {
        if (event.startsWith("data: ")) {
          listen(event.substring(6).trim());
        }
      });
    });
  });
}
