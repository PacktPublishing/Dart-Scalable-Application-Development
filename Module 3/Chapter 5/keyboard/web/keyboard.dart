import 'dart:html';

void main() {
  querySelector('#form1').onSubmit.listen(submit);
  document.onKeyPress.listen(_onKeyPress);
  window.onMouseWheel.listen(_onMouseWheel);
}

submit(Event e) {
  // code to be executed when submit button is clicked
}

_onKeyPress(KeyboardEvent e){
  e.preventDefault();
  print('The charCode is ${e.charCode}');
  if (e.keyCode == KeyCode.ENTER) submit(e);
  if (e.ctrlKey) return;

  switch(e.keyCode) {
    case KeyCode.DOWN:
      // move sprite down
      break;
    case KeyCode.UP:
      // move sprite up
      break;
    case KeyCode.F1:
      // show help
      break;
  }
}

_onMouseWheel(Event e) {
  print("${e.type}"); // prints "mousewheel"
}