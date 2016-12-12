void main() {
   Cat cat = new Animal("cat");
   Dog dog = new Animal("dog");
   print(cat.makeNoise());
}

abstract class Animal {
   String makeNoise();
   factory Animal(String type) {
       switch(type) {
         case "cat":
           return new Cat();
         case "dog":
           return new Dog();
         default:
           throw "The '$type' is not an animal";
       }
     }
}

class Cat implements Animal { String makeNoise() => 'Meow'; }
class Dog implements Animal { String makeNoise() => 'Woef'; }