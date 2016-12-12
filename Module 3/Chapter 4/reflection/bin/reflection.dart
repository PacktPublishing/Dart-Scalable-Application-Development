import 'dart:mirrors';

void main() {
    var embr = new Embrace(5);
    print(embr);  // Embraceometer reads 5
    embr.strength += 5;
    print(embr.toJson()); // {strength: 10}
    var embr2 = new Embrace(10);
    var bigHug = embr + embr2;
    // Start reflection code:
    final MirrorSystem ms = currentMirrorSystem();
     // Iterating through libraries
    ms
       .libraries
       .forEach((Uri name, LibraryMirror libMirror){
          print('$name $libMirror');
       });
    InstanceMirror im = reflect(embr);
    InstanceMirror im2 = im.invoke(#toJson, []);
    print(im2.reflectee); // {strength: 10}
    ClassMirror cm = reflectClass(Embrace);
    ClassMirror cm2 = im.type;
    printAllDeclarationsOf(cm);
    InstanceMirror im3 = cm.newInstance(#light, []);
    print(im3.reflectee.strength);
    im3.reflectee.withAffection();
}

printAllDeclarationsOf(ClassMirror cm) {
  for (var k in cm.declarations.keys) print(MirrorSystem.getName(k));
  // equivalent:
  //for (var m in cm.declarations.values) print(MirrorSystem.getName(m.simpleName));
}

class Embrace  {
   num _strength;
   num get strength => _strength;
   set strength(num value) => _strength=value;
   Embrace(this._strength);
   Embrace.light(): _strength=3;
   Embrace.strangle(): _strength=100;
   Embrace operator +(Embrace other) => new Embrace(strength + other.strength);
   String toString() => "Embraceometer reads $strength";
   Map toJson() => {'strength': '$_strength'};
   withAffection() {
     for (var no=0; no <= 3; no++) {
       for (var s=0; s <=5; s++) { strength = s; }
     }
   }
}