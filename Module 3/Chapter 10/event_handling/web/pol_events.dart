import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('pol-events')
class Polevents extends PolymerElement {
  @observable String which_event = "no event";
  @observable String thing = "";
  @observable String message = "";

  Polevents.created() : super.created();

  enter(KeyboardEvent  e, var detail, Node target) {
    if (e.keyCode == KeyCode.ENTER) {
      which_event = "you pressed the ENTER key";
    }
  }

  btnclick(MouseEvent  e, var detail, Node target) {
    message = (target as Element).attributes['data-msg'];
    which_event = "you clicked the button";
  }

  txtChange(Event e, var detail, Node target) {
    var inp = (target as InputElement).value;
    // assert(inp == thing);
    which_event = "you entered $inp in the text field";
  }

  cbClick(Event e, var detail, Node target) {
    which_event = "you changed the checkbox";
  }

  selChange(Event e, var detail, Node target) {
    which_event = "you selected another option";
  }
}