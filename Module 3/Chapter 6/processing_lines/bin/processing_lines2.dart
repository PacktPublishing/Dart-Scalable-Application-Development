import 'dart:io';
import 'dart:async';
import 'dart:convert';

var header = true;

main() {
  File inf = new File("../winequality-red.csv");
  // using openRead:
  Stream<List<int>> input = inf.openRead();
  input
    .transform(UTF8.decoder) // Decode to UTF8.
    .transform(new LineSplitter()) // Convert stream to individual lines.
    .listen(processLine, onDone: close, onError: handleError);
}

processLine(line) {  print('$line: ${line.length} bytes'); }
close() { print('File is now closed.'); }
handleError(e) { print(e.toString()); }