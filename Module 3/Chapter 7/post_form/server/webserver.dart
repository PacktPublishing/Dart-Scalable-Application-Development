import 'dart:io';
// import 'dart:convert';

const HOST = '127.0.0.1';
const PORT = 4040;
HttpResponse res;

void main() {
  //HttpServer.bind(HOST, PORT).then(acceptRequests, onError: handleError);
  HttpServer.bind(HOST, PORT)
            .then(acceptRequests)
            .catchError(handleError);
}

void acceptRequests(server) {
    server.listen((HttpRequest req) {
      switch (req.method) {
        case 'POST':
          handlePost(req);
          break;
        case 'GET':
          handleGet(req);
          break;
        case 'OPTIONS':
          handleOptions(req);
          break;
        default: defaultHandler(req);
      }
    },
    onError: handleError, // Listen failed.
    onDone: () => print('Data is delivered.'));
    print('Listening for GET and POST on http://$HOST:$PORT');
}

void handlePost(HttpRequest req) {
  res = req.response;
  addCorsHeaders(res);
  res.statusCode = HttpStatus.OK;
  req.listen(processData, onError: handleError);
}

processData(List<int> buffer) {
  res.write('OK, I received: ');
  var strJSON = new String.fromCharCodes(buffer);
  res.write(strJSON);
  // process incoming data:
//  var data = JSON.decode(strJSON);
//  print(data);
  res.close();
}

handleGet(HttpRequest req) {
  res = req.response;
  addCorsHeaders(res);
}

void handleOptions(HttpRequest req) {
  HttpResponse res = req.response;
  addCorsHeaders(res);
  res.statusCode = HttpStatus.NO_CONTENT;
  res.close();
}

void addCorsHeaders(HttpResponse res) {
  res.headers.add('Access-Control-Allow-Origin', '*');
  res.headers.add('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.headers.add('Access-Control-Allow-Headers',
      'Origin, X-Requested-With, Content-Type, Accept');
}

void defaultHandler(HttpRequest req) {
  res = req.response;
  res.statusCode = HttpStatus.METHOD_NOT_ALLOWED;
  res.write("Unsupported request: ${req.method}.");
  res.close();
}

handleError(e) {
  print(e);
  // other error handling
}