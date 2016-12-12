// use a factory constructor to implement the singleton pattern
class Immortal {
  static final Immortal theOne = new Immortal._internal('Connor MacLeod');
  String name;
  factory Immortal(name) => theOne;
  // private, named constructor
  Immortal._internal(this.name);
}

main() {
  // substitute your favorite search-engine for se1:
  var im1 = new Immortal('Juan Ramirez');
  var im2 = new Immortal('The Kurgan');
  print(im1.name);               // Connor MacLeod
  print(im2.name);               // Connor MacLeod
  print(Immortal.theOne.name);   // Connor MacLeod
  assert(identical(im1, im2));
}