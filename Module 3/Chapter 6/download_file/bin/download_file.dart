import 'dart:io';
import 'dart:convert';

var client;

main() {
  var url = Uri.parse('http://learningdart.org');
  client = new HttpClient();
  client.getUrl(url)
    .then((HttpClientRequest req) => req.close())
    .then((HttpClientResponse resp) => writeToFile(resp))
    .catchError(print);
//  .then((HttpClientResponse resp) => resp.pipe(new File('dart.txt').openWrite()));
}

writeToFile(resp) {
  resp.transform(UTF8.decoder)
      .toList().then((data) {
          var body = data.join('');
          var file = new File('dart.txt');
          file.writeAsString(body).then((_) {
            client.close();
          });
      });
}

