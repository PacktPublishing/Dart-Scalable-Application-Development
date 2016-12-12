import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('pol-map')
class Polmap extends PolymerElement {
  Map companies = toObservable({1: 'Google', 2: 'Microsoft'});

  Polmap.created() : super.created() {
    companies[3] = 'HP';
  }

  addcompanies(Event e, var detail, Node target) {
    companies[4] = 'Facebook';
    companies[5] = 'Apple';
  }
}