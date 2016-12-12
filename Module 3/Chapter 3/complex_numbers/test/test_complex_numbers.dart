import 'package:unittest/unittest.dart';
import 'package:complex_numbers/complex_numbers.dart';

main() {

  group('Testing constructors', () {
    test('Testing constructor without args',  () {
      ComplexNumber cn = new ComplexNumber();

      expect(cn.real, equals(0), reason:'real part (${cn.real}) must be 0');
      expect(cn.imag, equals(0), reason:'real part (${cn.imag}) must be 0');
    });

    test('Testing constructor with real part',  () {
      ComplexNumber cn = new ComplexNumber(5);

      expect(cn.real, equals(5), reason:'real part (${cn.real}) must be 5');
      expect(cn.imag, equals(0), reason:'real part (${cn.imag}) must be 0');
    });

    test('Testing constructor with real and imaginary part',  () {
      ComplexNumber cn = new ComplexNumber(5, 3);

      expect(cn.real, equals(5), reason:'real part (${cn.real}) must be 5');
      expect(cn.imag, equals(3), reason:'real part (${cn.imag}) must be 3');
    });
  });

  group('Testing toString', () {

    test('Testing constructor only with real part',  () {
      var cp1 = new ComplexNumber.re(1.0);
      expect(cp1.toString(), equals('1.0 + 0i')  );
    });

    test('Testing constructor only with imaginary part',  () {
      var cp1 = new ComplexNumber.im(1.0);
      expect(cp1.toString(), equals('0 + 1.0i')  );
    });

    test('Testing constructor with real and imaginary positive',  () {
      var cp1 = new ComplexNumber(1.0, 1.0);
      expect(cp1.toString(), equals('1.0 + 1.0i')  );
    });

    test('Testing constructor only with real part negative',  () {
      var cp1 = new ComplexNumber(-1.0, 0.0);
      expect(cp1.toString(), equals('-1.0 + 0.0i')  );
    });

    test('Testing constructor only with imaginary part negative',  () {
      var cp1 = new ComplexNumber(0.0, -1.0);
      expect(cp1.toString(), equals('0.0 - 1.0i')  );
    });
  });

  test('Testing the static constructor to make complex number with only imaginary part',  () {
    var num1 = new ComplexNumber.im(5.0);
    expect(num1.real, equals(0)  );
    expect(num1.imag, equals(5)  );
  });


  group('Tests with Operator plus',(){
    test( 'Testing operator plus with 2 complex number',(){
      var num1 = new ComplexNumber(2.0, 2.0);
      var num2 = new ComplexNumber(1.0, 1.0);

      var result = num1 + num2;

      expect(result.real, equals( 3.0));
      expect(result.imag, equals( 3.0));

      num1 = new ComplexNumber(2.0, 2.0);
      num2 = new ComplexNumber(-1.0, -1.0);

      result = num1 + num2;

      expect(result.real, equals( 1.0));
      expect(result.imag, equals( 1.0));
    });
  });

  group('Tests with Operator minus',(){
    test( 'Testing operator minus with 2 complex number',(){
      print('operatorPlusShouldReturnCorrectAnswer');
      var num1 = new ComplexNumber(2.0, 2.0);
      var num2 = new ComplexNumber(1.0, 1.0);

      var result = num1 - num2;

      expect(result.real, equals( 1.0));
      expect(result.imag, equals( 1.0));

      num1 = new ComplexNumber(2.0, 2.0);
      num2 = new ComplexNumber(1.0, -1.0);

      result = num1 - num2;

      expect(result.real, equals( 1.0));
      expect(result.imag, equals( 3.0));
    });
  });

  group('Test Multiplication operator', (){
    test('Teste operator * with 2 complex number', (){
      var num1 = new ComplexNumber(2.0, 1.0);
      var num2 = new ComplexNumber(3.0, 2.0);

      var result = num1 * num2;

      expect(result.real, equals( 4.0));
      expect(result.imag, equals( 7.0));

      num1 = new ComplexNumber(2.0, 2.0);
      num2 = new ComplexNumber(3.0, -3.0);

      result = num1 * num2;

      expect(result.real, equals( 12.0));
      expect(result.imag, equals(0.0));
    });
  });

  group('Test division operator', (){
    test('Teste operator / with 2 complex number', (){
      var num1 = new ComplexNumber(10.0, 3.0);
      var num2 = new ComplexNumber(2.0, 2.0);

      var result = num1 / num2;

      expect(result.real, equals( 3.25));
      expect(result.imag, equals( -1.75));

      num1 = new ComplexNumber(10.0, 3.0);
      num2 = new ComplexNumber(2.0, -2.0);

      result = num1 / num2;

      expect(result.real, equals( 1.75));
      expect(result.imag, equals( 3.25));
    });
  });

  test('Abs should return the correct answer', (){
    var num1 = new ComplexNumber(4.0, 3.0);
    expect(num1.abs, equals(5));
  });

  test('angle Should Return Correct Answer', (){
    var num1 = new ComplexNumber(1.0, 3.0);

    expect(num1.angle, closeTo(1.249, 0.01));
  });

}
/*
 * unittest-suite-wait-for-done
operatorPlusShouldReturnCorrectAnswer
PASS: Testing constructors Testing constructor without args
PASS: Testing constructors Testing constructor with real part
PASS: Testing constructors Testing constructor with real and imaginary part
PASS: Testing toString Testing constructor only with real part
PASS: Testing toString Testing constructor only with imaginary part
PASS: Testing toString Testing constructor with real and imaginary positive
PASS: Testing toString Testing constructor only with real part negative
PASS: Testing toString Testing constructor only with imaginary part negative
PASS: Testing the static constructor to make complex number with only imaginary part
PASS: Tests with Operator plus Testing operator plus with 2 complex number
PASS: Tests with Operator minus Testing operator minus with 2 complex number
PASS: Test Multiplication operator Teste operator * with 2 complex number
PASS: Test division operator Teste operator / with 2 complex number
PASS: Abs should return the correct answer
PASS: angle Should Return Correct Answer

All 15 tests passed.
unittest-suite-success
*/
