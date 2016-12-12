void main() {
  var p1 = new Person("Jane Wilkins", "485-56-7861", DateTime.parse("1973-05-08"));
  var p2 = new Person("Barack Obama", "432-94-1282", DateTime.parse("1961-08-04"));
  var p3 = p1;
  var p4 = new Person("Jane Wilkins", "485-56-7861", DateTime.parse("1973-05-08"));

  // with == and hashCode from Object:
  // (comment out == and hashCode in class Person)
  print(p2==p1); //false: p1 and p2 are different
  print(p3==p1); //true:  p3 and p1 are the same object
  print(p4==p1); //false: p4 and p1 are different objects
  print(identical(p1, p3)); //true
  print(identical(p1, p4)); //false
  print(p1.hashCode); // 998736967
  print(p2.hashCode); // 676682609
  print(p3.hashCode); // 998736967
  // with specific == and hashCode for class Person:
  print(p2==p1); //false: p1 and p2 are different
  print(p3==p1); //true:  p3 and p1 are the same object
  print(p4==p1); //true: p4 and p1 are the same Person
  print(identical(p1, p3)); //true
  print(identical(p1, p4)); //false
  print(p1.hashCode); // 105660000000
  print(p2.hashCode); // -265428000000
  print(p3.hashCode); // 105660000000
}

class Person {
  String name;
  String ssn; // social security number
  DateTime birthdate;

  Person(this.name, this.ssn, this.birthdate);
  toString() => 'I am $name, born on $birthdate';
  operator ==(Person other) => this.ssn == other.ssn;
  int get hashCode => birthdate.millisecondsSinceEpoch;
}
