import 'dart:io';
import 'package:http/http.dart' as http;

main() {
  var url = Uri.parse('http://learningdart.org');
  http.get(url).then((response) {
                  new File('dart.txt').writeAsBytes(response.bodyBytes);
                 })
               .catchError(print);
}