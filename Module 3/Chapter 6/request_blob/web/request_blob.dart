import 'dart:html';

// Making a FileReader object:
FileReader flr = new FileReader();
ImageElement img;

void main() {
  img = document.querySelector('#anImage');
  // var path = 'stadium.jpg';
  var path = 'https://farm1.staticflickr.com/2/1418878_1e92283336_m.jpg';
// Building the request for a blob:
  var request = new HttpRequest();
    request
    ..open('GET', path)
    ..responseType = 'blob'
    ..overrideMimeType("image/jpg")
    ..onLoadEnd.listen((e) => requestComplete(request))
    ..send('');
}
// Handling the response:
requestComplete(HttpRequest request) {
  if (request.status == 200 && request.readyState == HttpRequest.DONE) {
    Blob blob = request.response;
    flr.onLoadEnd.listen( (e) {
      img.src = flr.result;
    });
    flr.readAsDataUrl(blob);
   }
  else {
    print('Request failed, status={$request.status}');
  }
}