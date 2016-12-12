import 'dart:io';

const HOST = 'localhost';
const PORT = 8080;

main() {
  var wsurl = "ws://$HOST:$PORT/ws";
  WebSocket.connect(wsurl)
//Open the websocket and attach the callbacks
           .then((socket) {
              socket.add('from client: Hello Websockets Server!');
              socket.listen(onMessage, onDone: connectionClosed);
           })
           .catchError(print);
}

void onMessage(String msg){
  print(msg);
}

void connectionClosed() {
  print('Connection to server closed');
}