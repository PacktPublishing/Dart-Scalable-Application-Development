import 'dart:html';

void main() {
  var path = 'http://learningdart.org';
    var request = new HttpRequest();
    request
    ..open('GET', path)
    ..onLoadEnd.listen((e) => requestComplete(request))
    ..send('');
}

requestComplete(HttpRequest request) {
  if (request.status == 200) {
    print('headers: ${request.responseHeaders}');
    print('type: ${request.responseType}');
    print('********************************');
    print('text: ${request.responseText}');
   }
  else {
    print('Request failed, status={$request.status}');
  }
}