import 'dart:html';
import 'dart:js';
import 'package:polymer/polymer.dart';

@CustomTag('pol-js')
class PolJs extends PolymerElement {
  @observable String result;

  PolJs.created() : super.created();

  btnClick(Event e, var detail, Node target) {
    var pers1 = new JsObject(context['Person'], ['An', 'female']);
    result = pers1.callMethod('sayHello', [10]);
  }
}