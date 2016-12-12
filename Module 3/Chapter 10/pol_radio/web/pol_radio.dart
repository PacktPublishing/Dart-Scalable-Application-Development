import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('pol-radio')
class Polradio extends PolymerElement {
  @observable String favoriteJob = '';

  Polradio.created() : super.created();

  void getFavoriteJob(Event e, var detail, Node target) {
    favoriteJob = (e.target as InputElement).value;
  }
}