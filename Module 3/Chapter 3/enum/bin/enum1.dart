class IssueDegree {
  final _value;
  const IssueDegree(this._value);
  toString() => 'Enum.$_value';

  static const TRIVIAL = const IssueDegree('TRIVIAL');
  static const REGULAR = const IssueDegree('REGULAR');
  static const IMPORTANT = const IssueDegree('IMPORTANT');
  static const CRITICAL = const IssueDegree('CRITICAL');
}

void main() {
  var issueLevel = IssueDegree.IMPORTANT;
  // Warning and NoSuchMethodError for IssueLevel2:
  // There is no such getter ALARM in IssueDegree
  // var issueLevel2 = IssueDegree.ALARM;
    switch (issueLevel) {
      case IssueDegree.TRIVIAL:
        print("Ok, I'll sort it out during lunch");
        break;
      case IssueDegree.REGULAR:
        print("We'll assign it to Ellen, our programmer");
        break;
      case IssueDegree.IMPORTANT:
        print("Let's discuss it in a meeting tomorrow morning");
        break;
      case IssueDegree.CRITICAL:
        print('Warn the Boss!');
        break;
    }
}
// Let's discuss it in a meeting tomorrow morning
