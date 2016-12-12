import 'dart:io';
import 'package:args/args.dart';

const HOWTOUSE = 'usage: dart search.dart [-n] search-pattern file';
const LINENO = 'line-number';
ArgResults argResults;
var searchTerms = "";
File file;

void main(List<String> args) {
  final parser = new ArgParser()..addFlag(LINENO, negatable: false, abbr: 'n');
  argResults = parser.parse(args);
  if (argResults.rest.length < 2) {
    print(HOWTOUSE);
    exit(1);
  }
  final strFile = argResults.rest.last;
  File file = new File(strFile);
  searchTerms = argResults.rest.sublist(0, argResults.rest.length - 1);
  searchFile(file, searchTerms);
}

searchFile(File file, searchTerms) {
  file.readAsLines().then(searchLines).catchError(print);
}

searchLines(lines) {
  for (var i = 0; i < lines.length; i++) {
    for (var j = 0; j < searchTerms.length; j++) {
      if (lines[i].contains(searchTerms[j])) {
        printMatch(lines[i], i);
      }
    }
  }
}

void printMatch(String line, int i) {
  StringBuffer sb = new StringBuffer();
  if (argResults[LINENO]) sb.write('${i + 1}: ');
  sb.write(line);
  print(sb.toString());
}