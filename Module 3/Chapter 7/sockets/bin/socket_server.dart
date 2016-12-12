import 'dart:io';
import 'dart:convert';

InternetAddress HOST = InternetAddress.LOOPBACK_IP_V6;
const PORT = 7654;

void main() {
  ServerSocket.bind(HOST, PORT)
              .then((ServerSocket srv) {
                print('serversocket is ready');
                srv.listen(handleClient);
              })
              .catchError(print);
}

void handleClient(Socket client){
  print('Connection from: '
    '${client.remoteAddress.address}:${client.remotePort}');
  // data from client:
  client.transform(UTF8.decoder).listen(print);
  // data to client:
  client.write("Hello from Simple Socket Server!\n");
  client.close();
}