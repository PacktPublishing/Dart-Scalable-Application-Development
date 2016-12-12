import 'dart:math';

void main() {
   int points = 42; // starts as a smi
   print(points);  // 42
   points = pow(points, 10); // becomes a mint
   print(points); // 17080198121677824
   points = pow(points, 3); // becomes a bigint
   print(points);  // 4982860305982791130999719267476828621962135732224
}
