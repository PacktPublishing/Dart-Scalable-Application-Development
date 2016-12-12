import 'dart:io';
import 'dart:convert';

void main() {
  // 1- using writeAsString:
    final filename = 'outString.txt';
    new File(filename).writeAsString('Dart is an elegant language').then((File file) {
      // do something with the file.
    }).catchError((e) => handleError(e));
  // 2 - using writeAsBytes
    final string = '你好世界';
    // Encode to UTF8.
    var encodedData = UTF8.encode(string);
    new File('outUTF8.txt').writeAsBytes(encodedData).then((file)
        => file.readAsBytes()).then((data) {
      // Decode to a string, and print.
      print(data); // [228, 189, 160, 229, 165, 189, 228, 184, 150, 231, 149, 140]
      print(UTF8.decode(data)); // prints '你好世界'.
    }).catchError((e) => handleError(e));
  // 3 - using openWrite:
  var file = new File('out3.txt');
  var sink = file.openWrite(mode: FileMode.APPEND, encoding: ASCII);
  sink.write('File was written to at ${new DateTime.now()}\n');
  // close the IOSink to free system resources.
  sink.close();
}

handleError(e) {
  print("An error $e occurred");
}
