import 'dart:io';

InternetAddress HOST = InternetAddress.LOOPBACK_IP_V6;
const int PORT = 8080;

main() {
  HttpServer.bind(HOST, PORT)
            .then((server) {
              print('server starts listening on port ${server.port}');
              server.listen(handleRequest);
             })
             .catchError(print);
}

handleRequest(HttpRequest req) {
  print('request coming in');
//  print('headers: ${req.headers}');
//  print('uri: ${req.uri}');
//  print('method: ${req.method}');
  req.response
      ..headers.contentType = new ContentType("text", "plain", charset: "utf-8")
     ..write('I heard you loud and clear.')
     ..write(' Send me the data!')
     ..close();
}