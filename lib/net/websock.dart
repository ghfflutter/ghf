import 'dart:io';

Future<WebSocket> webSocket(String url,
    {void Function(dynamic)? onMessage,
    void Function()? onClose,
    Function()? onError}) async {
  WebSocket ws = await WebSocket.connect(url);
  ws.listen(onMessage, onDone: onClose, onError: onError);

  return ws;
}
