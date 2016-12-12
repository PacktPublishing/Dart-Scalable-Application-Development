import 'dart:io';
import 'dart:async';
import 'dart:convert';

var header = true;

main() {
  File data = new File("../winequality-red.csv");
  // using readAsLines:
    data.readAsLines(encoding: ASCII).then(processLines)
                     .catchError((e) => handleError(e));
  // using openRead:
  Stream<List<int>> input = data.openRead();
  input
    .transform(UTF8.decoder) // Decode to UTF8.
    .transform(const LineSplitter()) // Convert stream to individual lines.
    .listen((String line) { // Callback to rocess results.
      print('$line: ${line.length} bytes');
      // Further processing of line, e.g. as in processLines
    }, onDone: () {
      print('File is now closed.');
    }, onError: (e) {
      print(e.toString());
    });
}

processLines(List<String> lines) {
  // process lines:
  for (var line in lines) {
    print(line);
    // when not header line, split line on separator:
    if (!header) {
      List<String> fields = line.split(";");
      Wine wn = new Wine();
      wn.fixed_acidity = fields[0];
      wn.volatile_acidity = fields[1];
      // extracting remaining properties
      wn.alcohol = fields[10];
      wn.quality = fields[11];
      print(wn);
    }
    header = false;
  }
}

handleError(e) {
  print("An error $e occurred");
}

class Wine {
  var fixed_acidity;
  var volatile_acidity;
  var citric_acid;
  var residual_sugar;
  var chlorides;
  var free_sulfur_dioxide;
  var total_sulfur_dioxide;
  var density;
  var pH;
  var sulphates;
  var alcohol;
  var quality;

  toString() => "This wine has $fixed_acidity fixed acidity, " "alcohol % of $alcohol and quality $quality.";
}


//  file.openRead()
//      .transform(UTF8.decoder) // use a UTF8.decoder
//      .listen((String data) => print(data), // output the data
//        onError: (error) => print("Error, could not open file"),
//        onDone: () => print("Finished reading data"));
