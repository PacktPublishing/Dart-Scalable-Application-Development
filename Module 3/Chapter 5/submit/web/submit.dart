import 'dart:html';

void main() {
  querySelector('#form1').onSubmit.listen(submit);
}

submit(Event e) {
  // code to be executed when submit button is clicked
   e.preventDefault();
}