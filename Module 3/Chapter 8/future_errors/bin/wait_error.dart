import 'dart:async';

main() {
  Future<int> a = new Future(() {
    print('a');
    return 1;
  });
  Future<int> b = new Future.error('Error occurred in b!');
  Future<int> c = new Future(() {
    print('c');
    return 3;
  });
//  Future<int> d = new Future(() {
//      print('d');
//      return 4;
//  });
  Future<int> d = new Future(() { throw('Error occurred in d!'); });

  Future.wait([a, b, c, d]).then((List<int> values) => print(values)).catchError(print);
  print('happy end');
}
