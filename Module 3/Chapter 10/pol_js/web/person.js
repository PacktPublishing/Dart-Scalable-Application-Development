function Person(name, gender) {
  this.name = name;
  this.gender = gender;
  this.greeting = function(otherPerson) {
    alert('I greet you ' + otherPerson.name);
  };
}

Person.prototype.sayHello = function(times) {
  return times + ' x: hello, I am ' + this.name;
};