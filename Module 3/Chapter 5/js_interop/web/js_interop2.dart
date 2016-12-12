import 'package:js/js.dart' as js;

void main() {
  // getting a variable:
  var dart = js.context['jsvar'];
  print(dart); // I want Dart
  // making objects:
  var pers1 = new js.Proxy(js.context.Person, ['An', 'female']);
  var pers2 = new js.Proxy(js.context.Person, ['John', 'male']);
// accessing and setting properties:
  print(pers1.name); // prints the whole object: [An, female]
  pers1.name = 'Melissa'; // change name property
  print(pers1.name); // Melissa
// calling methods:
  pers1.sayHello.call(); // window: hello, I am Melissa
  pers2.greeting.call(pers1); // window: I greet you Melissa
  // getting the global object in JavaScript via context
  js.context.alert('Hello from Dart via JavaScript');
  // using jsify:
  var jsMap = js.map({'a': 1,'b': 2});
  print(jsMap); // [object Object]
  var jsArray = js.array([1, 2, 3]);
  print(jsArray); // [1, 2, 3]
}
