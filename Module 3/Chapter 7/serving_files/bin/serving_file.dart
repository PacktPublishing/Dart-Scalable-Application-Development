import 'dart:io';
import 'package:http_server/http_server.dart';

InternetAddress HOST = InternetAddress.LOOPBACK_IP_V6;
const PORT = 8080;

void main() {
  VirtualDirectory staticFiles = new VirtualDirectory('.');
  HttpServer.bind(HOST, PORT).then((server) {
      server.listen((req) {
        staticFiles.serveFile(new File('Learning Dart Packt Publishing.html'), req);
      });
    });
}
