library salary;

import 'package:angular/angular.dart';

@Component(
    selector: 'x-salary',
    templateUrl: 'packages/angular_service/salary/salary_component.html',
    cssUrl: 'packages/angular_service/salary/salary_component.css',
    publishAs: 'cmp')
class SalaryComponent {
  static const String _STAR_ON_CHAR = "\u2605";
  static const String _STAR_OFF_CHAR = "\u2606";
  static const String _STAR_ON_CLASS = "star-on";
  static const String _STAR_OFF_CLASS = "star-off";

  static final int DEFAULT_MAX = 10;

  List<int> stars = [];

  @NgOneWay('salary')
  int salary;

  @NgAttr('max-sal')
  void set maxSal(String value) {
    var count = value == null
        ? DEFAULT_MAX
        : int.parse(value, onError: (_) => DEFAULT_MAX);
    stars = new List.generate(count, (i) => i + 1);
  }

  String starClass(int star) =>
      star > salary ? _STAR_OFF_CLASS : _STAR_ON_CLASS;

  String starChar(int star) => star > salary ? _STAR_OFF_CHAR : _STAR_ON_CHAR;
}
