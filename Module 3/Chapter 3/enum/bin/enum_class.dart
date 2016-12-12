class Enum {
  final _value;
  const Enum(this._value);
  toString() => 'Enum.$_value';

  static const VAL1 = const Enum('VAL1');
  static const VAL2 = const Enum('VAL2');
  static const VAL3 = const Enum('VAL3');
  static const VAL4 = const Enum('VAL4');
  static const VAL5 = const Enum('VAL5');
}