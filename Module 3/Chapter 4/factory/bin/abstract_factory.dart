void main() {
  // factory as a default implementation of an abstract class:
   Cat cat = new Animal();
   var catSound = cat.makeNoise();
   print(catSound); // Meow
}

abstract class Animal {
   String makeNoise();
   factory Animal() => new Cat();
}

class Cat implements Animal { String makeNoise() => 'Meow'; }
class Dog implements Animal { String makeNoise() => 'Woef'; }