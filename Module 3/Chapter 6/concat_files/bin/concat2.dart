import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';

ArgResults argResults;
File output;
IOSink snk;

void main(List<String> arguments) {
  final parser = new ArgParser();
  argResults = parser.parse(arguments);
  final outFile = argResults.rest.last;
  List<String> files = argResults.rest.sublist(0, argResults.rest.length - 1);
  if (files.isEmpty) {
     print('No files provided to concatenate!');
   }
   output = new File(outFile);
   if (output.existsSync()) {
     output.delete();
   }
   concat(files);
   snk.flush();
}

Future concat(List<String> files) {
  snk = output.openWrite(mode: FileMode.APPEND);
  return Future.forEach(files, (file) {
    Stream<List<int>> stream = new File(file).openRead();
    return stream.transform(UTF8.decoder)
                 .transform(const LineSplitter())
                 .listen((line) {
                      snk.write(line + "\n");
    }).asFuture().catchError((_) => _handleError(file));
  });
}

_handleError(String file) {
  FileSystemEntity.isDirectory(file).then((isDir) {
    if (isDir) {
      print('error: $file is a directory');
    } else {
      print('error: $file not found');
    }
  });
}