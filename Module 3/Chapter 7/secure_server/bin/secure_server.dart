import 'dart:io';

InternetAddress HOST = InternetAddress.LOOPBACK_IP_V6;
const int PORT = 4777;

main() {
  var testcertDb = Platform.script.resolve('pkcert').toFilePath();
  SecureSocket.initialize(database: testcertDb, password: 'dartdart');

  HttpServer.bindSecure(HOST, PORT, certificateName: 'localhost_cert').then((server) {
    print('Secure Server listening');
    server.listen((HttpRequest req) {
      print('Request for ${req.uri.path}');
      var resp = req.response;
      resp.write("Don't worry: I encrypt your messages!");
      resp.close();
    });
  });
}
