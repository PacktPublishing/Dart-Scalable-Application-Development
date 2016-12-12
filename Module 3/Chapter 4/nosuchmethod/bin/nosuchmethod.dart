void main() {
  var embr = new Embrace(5);
  print(embr.missing("42", "Julia"));
}

@proxy
class Embrace {
  num _strength;
  num get strength => _strength;
  set strength(num value) => _strength = value;
  Embrace(this._strength);
  Embrace.light(): _strength = 3;
  Embrace.strangle(): _strength = 100;
  Embrace operator +(Embrace other) => new Embrace(strength + other.strength);
  String toString() => "Embraceometer reads $strength";
  Map toJson() => {'strength': '$_strength'};

  @override
  noSuchMethod(Invocation msg) => "got ${msg.memberName} "
               "with arguments ${msg.positionalArguments}";
}
// got Symbol("missing") with arguments [42, Julia]