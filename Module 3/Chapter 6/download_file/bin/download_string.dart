import 'dart:html';

main() {
   HttpRequest.getString('http://learningdart.org')
  .then(processString)
  .catchError(print);
}

processString(str) {
  print(str);
}
