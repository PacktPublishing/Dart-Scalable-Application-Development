import 'dart:html';

void main() {
  TextInputElement inp = querySelector('#input');
  DivElement out = querySelector('#output');

  String srvuri = 'ws://localhost:8080/ws';
  WebSocket ws = new WebSocket(srvuri);

  inp.onChange.listen((Event e){
      ws.send(inp.value.trim());
      inp.value = "";
    });

  ws.onOpen.listen((Event e) {
    outputMessage(out, 'Connected to server');
  });

  ws.onMessage.listen((MessageEvent e){
    outputMessage(out, e.data);
  });

  ws.onClose.listen((Event e) {
    outputMessage(out, 'Connection to server lost...');
  });

  ws.onError.first.then((_) {
       print("Failed to connect to ${ws.url}. "
             "Please rerun bin/websocket_server.dart and try again.");
  });
}

void outputMessage(Element e, String message){
  print(message);
  e.appendText(message);
  e.appendHtml('<br/>');

  //Make sure we 'autoscroll' the new messages
  e.scrollTop = e.scrollHeight;
}