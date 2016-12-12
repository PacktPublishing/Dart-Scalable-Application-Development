import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('dom-extend')
class Domextend extends DivElement with Polymer, Observable {
  Domextend.created() : super.created() {
    polymerCreated();
    text = "I am not an ordinary div!";
  }
}