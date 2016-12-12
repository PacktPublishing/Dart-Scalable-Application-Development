import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('find-nodes')
class Findnodes extends PolymerElement {
  Findnodes.created() : super.created();

  btnclick(MouseEvent  e, var detail, Node target) {
    // making the paragraph visible:
    $['show'].style
       ..display = 'inline'
       ..color = 'red';
    // changing the text inside the div:
    Element insideDiv = $['findme'];
    insideDiv.text = 'I was looked up by \$ and changed!';
  }
}