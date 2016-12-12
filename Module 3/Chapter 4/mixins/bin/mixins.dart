void main() {
  var embr = new Embrace(5);
  print(embr.save(embr.strength)); // You are saved with strength 5!
  print(embr is Movement); // true
  print(embr is Persistable); // true
}

class Embrace extends Movement with Persistable {
  num _strength;
  num get strength => _strength;
  set strength(num value) => _strength = value;
  Embrace(this._strength);
  Embrace.light(): _strength = 3;
  Embrace.strangle(): _strength = 100;
  Embrace operator +(Embrace other) => new Embrace(strength + other.strength);
  String toString() => "Embraceometer reads $strength";
  Map toJson() => {'strength': '$_strength'};
 }

class Movement {
  String name;
  Movement();
 }

abstract class Persistable {
  save(var s) {
    // saving in data store
    return "You are saved with strength $s!";
  }
  load() => "You are loaded!";
}
