import 'dart:math';

void main() {
   Cat an = new Animal();
   print(an.makeNoise());
}

abstract class Animal {
   // simulates computation:
   factory Animal() {
       var random = new Random();
       if (random.nextBool())
         return new Cat();
       else
         return new Dog();
   }
}

class Cat implements Animal { String makeNoise() => 'Meow'; }
class Dog implements Animal { String makeNoise() => 'Woef'; }