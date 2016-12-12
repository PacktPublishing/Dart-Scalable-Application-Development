const Anno = "Meta";

void main() {
  var embr = new Embrace(5);
  print(embr);
  var str = new Embrace.strangle();
}

@Anno
@ToFix("Improve the algorithms", "Bill Gates")
class Embrace extends Movement {
  num _strength;
  num get strength => _strength;
  set strength(num value) => _strength = value;
  Embrace(this._strength);
  Embrace.light(): _strength = 3;

  @deprecated
  Embrace.strangle(): _strength = 100;

  @override consumedcalories() { } // <-- warning

  Embrace operator +(Embrace other) => new Embrace(strength + other.strength);
  String toString() => "Embraceometer reads $strength";
  Map toJson() => {'strength': '$_strength'};
 }

class Movement {
  String Name;
  Movement();
  consumedCalories() {
    // calculation of calories
  }
}

class ToFix {
  final String note, author, date;
  const ToFix(this.note, this.author, {this.date});
}