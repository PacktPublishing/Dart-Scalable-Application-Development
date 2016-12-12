import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

@MirrorsUsed(override: '*')
import 'dart:mirrors';

void main() {
  applicationFactory().run();
}