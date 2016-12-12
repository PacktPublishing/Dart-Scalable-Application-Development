import 'dart:io';
import 'package:args/args.dart';

ArgResults argResults;
File output;

void main(List<String> arguments) {
  final parser = new ArgParser();
  argResults = parser.parse(arguments);
  final outFile = argResults.rest.last;
  List<String> files = argResults.rest.sublist(0, argResults.rest.length - 1);
  if (files.isEmpty) {
    print('No files provided to concatenate!');
    exit(1);
  }
  output = new File(outFile);
  if (output.existsSync()) {
    output.delete();
  }
  concat(files);
}

concat(List<String> files) {
  for (var file in files) {
    var input = new File(file);
    try {
      var content = input.readAsStringSync();
      content += "\n";
      output.writeAsStringSync(content, mode: FileMode.APPEND);
    } catch (e) {
      print("An error $e occurred");
    }
  }
}