var jsvar = "I want Dart";

function Person(name, gender) {
  this.name = name;
  this.gender = gender;
  this.greeting = function(otherPerson) {
    alert('I greet you ' + otherPerson.name);
  };
}

Person.prototype.sayHello = function () {
  alert ('hello, I am ' + this.name );
};