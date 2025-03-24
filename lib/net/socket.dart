import 'dart:io';

Future<Socket> socket(String host, int port,
    {void Function(String)? onMessage,
    void Function()? onClose,
    Function()? onError}) async {
  Socket ws = await Socket.connect(host, port);
  ws.listen((List<int> data) {
    String message = String.fromCharCodes(data);
    onMessage!(message);
  }, onDone: () {
    ws.destroy();
    onClose!();
  }, onError: () {
    ws.destroy();
    onError!();
  });
  return ws;
}
