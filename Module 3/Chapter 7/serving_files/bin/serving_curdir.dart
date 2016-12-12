import 'dart:io';
import 'dart:async';
import 'package:http_server/http_server.dart';

InternetAddress HOST = InternetAddress.LOOPBACK_IP_V6;
const PORT = 8080;
VirtualDirectory staticFiles;

void main() {
  staticFiles = new VirtualDirectory('.')
    ..allowDirectoryListing = true;

  runZoned( startServer, onError: handleError);
}

startServer() {
    HttpServer.bind(HOST, PORT).then((server) {
      server.listen(staticFiles.serveRequest);
    });
}

handleError(e, stackTrace) {
  print('An error occurred: $e $stackTrace');
}