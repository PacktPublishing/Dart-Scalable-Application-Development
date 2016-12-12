import 'package:polymer/polymer.dart';

@CustomTag('pol-oven')
class Poloven extends PolymerElement {
  // @published means 'this is an attribute', and it is observable.
  @published int temperature = 0;

  Poloven.created() : super.created() {  }
}