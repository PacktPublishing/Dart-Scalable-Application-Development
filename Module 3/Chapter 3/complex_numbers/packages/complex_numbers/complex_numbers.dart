library complex_numbers;

import 'dart:math' as math;

class ComplexNumber {
  num _real;
  num _imag;

  // constructors:
  ComplexNumber([this._real = 0, this._imag = 0]);
  ComplexNumber.im(num imag) : this(0, imag);
  ComplexNumber.re(num real) : this(real, 0);

  // utility methods:
  num get real => _real;
  set real(num value) => _real = value;

  num get imag => _imag;
  set imag(num value) => _imag = value;

  num get abs => math.sqrt(real * real + imag * imag);

  num get angle => math.atan2(imag, real);

  bool operator ==(other) {
    if (!(other is ComplexNumber)) {
      return false;
    }
    return this.real == other.real && this.imag == other.imag;
  }

  String toString() {
    if (_imag >= 0) {
      return '${_real} + ${_imag}i';
    }
    return '${_real} - ${_imag.abs()}i';
  }

  // operator overloading:
  ComplexNumber operator +(ComplexNumber x) {
    return new ComplexNumber(_real + x.real, _imag + x.imag);
  }

  ComplexNumber operator -(var x) {
    if (x is ComplexNumber) {
      return new ComplexNumber(this.real - x.real, this.imag - x.imag);
    } else if (x is num) {
      _real -= x;
      return this;
    }
    throw 'Not a number';
  }

  ComplexNumber operator *(var x) {
    if (x is ComplexNumber) {
      num realAux = (this.real * x.real - this.imag * x.imag);
      num imagAux = (this.imag * x.real + this.real * x.imag);

      return new ComplexNumber(realAux, imagAux);
    } else if (x is num) {
      return new ComplexNumber(this.real * x, this.imag * x);
    }
    throw 'Not a number';
  }

  ComplexNumber operator /(var x) {
    if (x is ComplexNumber) {
      num realAux = (this.real * x.real + this.imag * x.imag) / (x.real * x.real + x.imag * x.imag);
      num imagAux = (this.imag * x.real - this.real * x.imag) / (x.real * x.real + x.imag * x.imag);

      return new ComplexNumber(realAux, imagAux);
    } else if (x is num) {
      return new ComplexNumber(this.real / x, this.imag / x);
    }
    throw 'Not a number';
  }

  // methods:
  static ComplexNumber add(ComplexNumber c1, ComplexNumber c2) {
    num rr = c1.real + c2.real;
    num ii = c1.imag + c2.imag;
    return new ComplexNumber(rr, ii);
  }

  static ComplexNumber subtract(ComplexNumber c1, ComplexNumber c2) {
    num rr = c1.real - c2.real;
    num ii = c1.imag - c2.imag;
    return new ComplexNumber(rr, ii);
  }

  static ComplexNumber multiply(ComplexNumber c1, ComplexNumber c2) {
    num rr = c1.real * c2.real - c1.imag * c2.imag;
    num ii = c1.real * c2.imag + c1.imag * c2.real;
    return new ComplexNumber(rr, ii);
  }

  static ComplexNumber divide(ComplexNumber c1, ComplexNumber c2) {
    num real = (c1.real * c2.real + c1.imag * c2.imag) / (c2.real * c2.real + c2.imag * c2.imag);
    num imag = (c1.imag * c2.real - c1.real * c2.imag) / (c2.real * c2.real + c2.imag * c2.imag);
    return new ComplexNumber(real, imag);
  }
}