import 'dart:io';
import 'dart:async';
// import 'package:route/server.dart' show Router;

InternetAddress HOST = InternetAddress.ANY_IP_V6;
const PORT = 8080;

main() {
  runZoned(startWSServer, onError: handleError);
}

startWSServer() {
  HttpServer.bind(HOST, PORT).then((server) {
    print('Http server started on $HOST $PORT');
//    Router router = new Router(server);
//    router.serve('/ws').transform(new WebSocketTransformer()).listen(handleWebSocket);
    server.listen(handleRequest);
  });
}

handleError(e, stackTrace) {
  print('An error occurred: $e $stackTrace');
}

handleRequest(HttpRequest req) {
    if ( (req.uri.path == '/ws') // command-line client
         || WebSocketTransformer.isUpgradeRequest(req) // web-client
       ){
  // Upgrade a HttpRequest to a WebSocket connection.
       WebSocketTransformer.upgrade(req).then(handleWebSocket);
    }
    else {
      print("Regular ${req.method} request for: ${req.uri.path}");
      serveNonWSRequest(req);
    }
}

handleWebSocket(WebSocket socket) {
  print('Client connected!');
  socket.listen((String msg) {
    print('Message received: $msg');
    socket.add('echo from server: $msg');
  }, onError: (err) {
    print('Bad WebSocket request $err');
  }, onDone: () {
    print('Client disconnected');
  });
}

serveNonWSRequest(req) {
  var resp = req.response;
  resp.statusCode = HttpStatus.FORBIDDEN;
  resp.reasonPhrase = "WebSocket connections only";
  resp.response.close();
}
