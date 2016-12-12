import 'package:complex_numbers/complex_numbers.dart';

ComplexNumber c1, c2, cres, cn;

void main() {
  cn = new ComplexNumber(1, 1);
  print("real = ${cn.real}");
  print("imag = ${cn.imag}");
  print("cn = " + cn.toString());

  // using operators:
  c1 = new ComplexNumber(3, -5);
  c2 = new ComplexNumber(6, 7);
  cres = c1 + c2;

  print("cres.real = ${cres.real}");
  print("cres.imag = ${cres.imag}");
  print("cres = " + cres.toString());

  cres = c1 - c2;
  print("cres.real = ${cres.real}");
  print("cres.imag = ${cres.imag}");
  print("cres = " + cres.toString());

  c1 = new ComplexNumber(2, 3);
  c2 = new ComplexNumber(4, 7);
  cres = c1 * c2;
  print("cres.real = ${cres.real}");
  print("cres.imag = ${cres.imag}");
  print("cres = " + cres.toString());

  c1 = new ComplexNumber(2, -1);
  c2 = new ComplexNumber(3, 2);
  cres = c1 / c2;
  print("cres.real = ${cres.real}");
  print("cres.imag = ${cres.imag}");
  print("cres = " + cres.toString());

  // using static methods:
  c1 = new ComplexNumber(2, 3);
  c2 = new ComplexNumber(2, -3);
  cres = ComplexNumber.add(c1, c2);
  print("cres.real = ${cres.real}");
  print("cres.imag = ${cres.imag}");
  print("cres = " + cres.toString());
  cres = ComplexNumber.subtract(c1, c2);
  print("cres.real = ${cres.real}");
  print("cres.imag = ${cres.imag}");
  print("cres = " + cres.toString());
  cres = ComplexNumber.multiply(c1, c2);
  print("cres.real = ${cres.real}");
  print("cres.imag = ${cres.imag}");
  print("cres = " + cres.toString());
  cres = ComplexNumber.divide(c1, c2);
  print("cres.real = ${cres.real}");
  print("cres.imag = ${cres.imag}");
  print("cres = " + cres.toString());
}
