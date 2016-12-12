import 'dart:typed_data';

void main() {
  var a = new Float32x4(14.1, 6.7, 56.3, 78.41);
  var b = new Float32x4(12.3, 5.4, 81.7, 13.43);
  Float32x4 sum = new Float32x4.zero(); //
  print(sum); // [0.000000, 0.000000, 0.000000, 0.000000]
  sum = a + b;
  print(sum); // [26.400002, 12.100000, 138.000000, 91.840004]
  print(sum.z); // 138.0
  // b.y = 3.14;  // --> NoSuchMethodError
  b = b.withY(3.14);
  print(b); // [12.300000, 3.140000, 81.699997, 13.430000]
  b = b.shuffle(Float32x4.WYXZ);
  print(b); // [13.430000, 3.140000, 12.300000, 81.699997]
  // a < b; // There is no such operator in Float32x4
  Int32x4 mask = a.greaterThan(b);  // Create selection mask.
  Float32x4 c = mask.select(a, b);   // Select.
  print(c); // [14.100000, 6.700000, 56.299999, 81.699997]
  // selectively applying an operation:
  Float32x4 v = new Float32x4(22.0, 33.0, 44.0, 55.0);
  // mask = [0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x0]
  mask = new Int32x4.bool(true, true, false, true);
  // r = [4.0, 9.0, 16.0, 25.0].
  Float32x4 r = v - v;
  v = mask.select(r, v);
  print(v); // [0.000000, 0.000000, 44.000000, 0.000000]
}
