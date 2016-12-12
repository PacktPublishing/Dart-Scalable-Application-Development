import 'package:polymer/polymer.dart';

@CustomTag('pol-select')
class Polselect extends PolymerElement {
   final List companies = toObservable(['Google', 'Apple', 'Mozilla', 'Facebook']);
   @observable int selected = 2; // Make sure this is not null; set it to the default selection index.
   @observable String value = 'Mozilla';

  Polselect.created() : super.created();
}