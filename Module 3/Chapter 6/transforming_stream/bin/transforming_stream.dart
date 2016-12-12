import 'dart:async';

var persons = [
   ['Carter', 'F'],
   ['Gates',  'M'],
   ['Nuryev', 'M'],
   ['Liszt', 'U'],
   ['Besançon', 'F']
];

void main() {
  var stream = new Stream.fromIterable(persons);
  // define a stream transformer
  var transformer = new StreamTransformer.fromHandlers(handleData: convert);
  // transform the stream and listen to its output
  stream
      .where((value) => value[1] != 'U')
      .transform(transformer)
      .listen((value) => print("$value"));
}

convert(value, sink) {
  // create new value from the original value
   var greeting = "Hello Mr. or Mrs. ${value[0]}";
   if (value[1] == 'F') {
     greeting = "Hello Mrs. ${value[0]}";
   }
   else if (value[1] == 'M') {
        greeting = "Hello Mr. ${value[0]}";
   }
   sink.add(greeting);
}
