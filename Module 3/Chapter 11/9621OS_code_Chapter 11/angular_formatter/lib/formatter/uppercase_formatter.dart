import 'package:angular/angular.dart';

@Formatter(name: 'uppercase')
class UppercaseFormatter {
  call(String name) {
    if (name == null || name.isEmpty) return '';
    return name.toUpperCase();
  }
}
