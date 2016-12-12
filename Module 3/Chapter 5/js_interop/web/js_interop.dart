import 'dart:js';

main() {
  // getting a variable:
  var dart = context['jsvar'];
  print(dart);  // I want Dart
  // making objects:
  var pers1 = new JsObject(context['Person'], ['An', 'female']);
  var pers2 = new JsObject(context['Person'], ['John', 'male']);
  // accessing and setting properties:
  print(pers1['name']); // An
  print(pers2['gender']); // male
  pers2['gender'] = 'female';
  print(pers2['gender']); // female
  // calling methods:
  pers1.callMethod('sayHello', []); // window: hello, I am An
  pers2.callMethod('greeting', [pers1]); // window: I greet you An
  // getting the global object in JavaScript via context
  context.callMethod('alert', ['Hello from Dart!']);
  // using jsify:
  var jsMap = new JsObject.jsify({'a': 1, 'b': 2});
  print(jsMap); // [object Object]
  var jsArray = new JsObject.jsify([1, 2, 3]);
  print(jsArray); // [1, 2, 3]
}
