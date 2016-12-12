void main() {
 var p = new Person();
 p.Name = "Joe";
 if (p is Person) {
   print('p is called ${p.Name}');
   print('p is of type ${p.runtimeType}'); //p is of type Person
 }
 else {
   // p has value null and is of type Null
   print('p has value $p and is of type ${p.runtimeType}');
 }
 // var n = int.parse('DART');  // FormatException
 var pi = 3.1415;
 var t = true;
 print(toInt(t)); // 1
}

class Person {
  String Name;
}

int toInt(bool val) => val ? 1 : 0;