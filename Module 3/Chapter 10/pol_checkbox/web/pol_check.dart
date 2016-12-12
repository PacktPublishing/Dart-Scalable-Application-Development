import 'package:polymer/polymer.dart';

@CustomTag('pol-check')
class Polcheck extends PolymerElement {
  @observable bool receive = false;

  Polcheck.created() : super.created();
}