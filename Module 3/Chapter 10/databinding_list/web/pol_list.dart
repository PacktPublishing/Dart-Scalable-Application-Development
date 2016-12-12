import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('pol-list')
class Pollist extends PolymerElement {
  final List companies = toObservable(['Google', 'Apple', 'Microsoft', 'Facebook']);

  Pollist.created() : super.created() {
     companies.add('HP');
  }

  addcompanies(Event e, var detail, Node target) {
    companies.add('IBM');
    companies.add('Dell');
  }
}