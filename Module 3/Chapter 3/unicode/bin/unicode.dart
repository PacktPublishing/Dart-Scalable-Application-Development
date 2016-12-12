String country = "Egypt";
String city = "Zürich";
String japanese = "日本語"; // nihongo meaning 'Japanese'

void main() {
  print('Unicode escapes: \uFE18'); //  the ︘ symbol
  print(country[0]);                 // E
  print(country.codeUnitAt(0));      // 69
  print(country.codeUnits);          // [69, 103, 121, 112, 116]
  print(country.runes.toList());     // [69, 103, 121, 112, 116]
  print(new String.fromCharCode(69)); // E
  print(new String.fromCharCodes([69, 103, 121, 112, 116])); // Egypt
  print("");
  //
  print(city[1]);                 // ü
  print(city.codeUnitAt(1));      // 252
  print(city.codeUnits);          // [90, 252, 114, 105, 99, 104]
  print(city.runes.toList());     // [90, 252, 114, 105, 99, 104]
  print(new String.fromCharCode(252)); // ü
  print(new String.fromCharCodes([90, 252, 114, 105, 99, 104])); // Zürich
  print("");
   //
  print(japanese[0]);                 // 日
  print(japanese.codeUnitAt(0));      // 26085
  print(japanese.codeUnits);          // [26085, 26412, 35486]
  print(japanese.runes.toList());     // [26085, 26412, 35486]
  print(new String.fromCharCode(35486)); // 語
  print(new String.fromCharCodes([26085, 26412, 35486])); // 日本語
}
