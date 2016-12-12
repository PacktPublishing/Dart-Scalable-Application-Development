import 'dart:io';

InternetAddress HOST = InternetAddress.LOOPBACK_IP_V6;
const PORT = 7654;

void main() {
  Socket.connect("google.com", 80).then((socket) {
    print('Connected to: '
      '${socket.remoteAddress.address}:${socket.remotePort}');
    socket.destroy();
  });
// prints: Connected to: 173.194.65.101:80

  Socket.connect(HOST, PORT).then((socket) {
     print(socket.runtimeType);
     // data to server:
     socket.write('Hello, World from a client!');
     // data from server:
     socket.listen(onData);
   });
}

onData(List<int> data) {
   print(new String.fromCharCodes(data));
}