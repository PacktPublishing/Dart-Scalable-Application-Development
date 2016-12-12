var u = "Julia";

void main() {
  var embr = new Embrace(5);
  embr(u); // callable methods!
  var m = new Mult();
  print(m(3, 4));
  print(Multi(3, 4));
  assert(Multi is IntOp);
  f = Multi;
  print(f(3, 4));
  assert(f is IntOp);
}

typedef int IntOp(int a, int b);
Function f;
int Multi(int a, int b) => a * b;

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

  call(var user) { print("$user is called, and hugged with strength $strength!"); }
 }

class Mult{
  call(int a, int b) => a * b;
}
// Julia is called, and hugged with strength 5!
// 12