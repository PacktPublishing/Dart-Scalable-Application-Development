main() {
  // 1 - return an object from a cache
  var sv = new Service('Credit Card Validation');
  sv.serve('Validate card number');
  // 2 - create an object from a subtype
  Person p = new Person("S. Hawking");
  print(p); // S. Hawking
  // 3 - singleton pattern - see next recipe
}
// 1 - return an object from a cache
class Service {
  final String name;
  bool mute = false;
  // _cache is library-private, thanks to the _ in front of its name.
  static final Map<String, Service> _cache = <String, Service>{};

  Service._internal(this.name);

  factory Service(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final serv = new Service._internal(name);
      _cache[name] = serv;
      return serv;
    }
  }

  void serve(String msg) {
      if (!mute) {
        print(msg); // Validate card number

      }
    }
}
// 2 - create an object from a subtype
class Person {
  factory Person(name) => new Teacher(name);
}

class Teacher implements Person {
  String name;
  Teacher(this.name);
  toString() => name;
}