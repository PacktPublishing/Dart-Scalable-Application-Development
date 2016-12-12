var visa = new RegExp(r"^(?:4[0-9]{12}(?:[0-9]{3})?)$");
var visa_in_text = new RegExp(r"\b4[0-9]{12}(?:[0-9]{3})?\b");
var input = "4457418557635128";
var text = "Does this text mention a VISA 4457418557635128 number?";


void main() {
  print(visa.pattern); // ^(?:4[0-9]{12}(?:[0-9]{3})?)$
  // is there a visa pattern match in input?
  if (visa.hasMatch(input)) {
    print("Could be a VISA number");
  }
  // does string input contain pattern visa?
  if (input.contains(visa)) {
    print("Could be a VISA number");
  }
  // find all matches:
  var matches = visa_in_text.allMatches(text);
  for (var m in matches) {
    print(m.group(0));
  }
  visa_in_text.allMatches(text).forEach((m) => print(m[0]));
  // let's hide the number:
  print(text.replaceAll(visa_in_text, 'XXXXXXXXXXXXXXXX'));
  print(visa.isCaseSensitive);
  print(visa.isMultiLine);
}
