void main() {
  // concatenation:
  String s1 = "Dart", s2 = "Cook", s3 = "Book";
  var res = "Dart" " Cook" "Book";
  res = "Dart"  " Cook"
              "Book";
  res = s1 + " " + s2 + s3;
  res = "$s1 $s2$s3";
  res = [s1, " ", s2, s3].join();

  var sb = new StringBuffer();
  sb.writeAll([s1, " ", s2, s3]);
  res = sb.toString();
  print(res); // Dart CookBook
  sb.writeAll([s1, " ", s2, s3],'-');
  res = sb.toString();
  print(res); // Dart- -Cook-Book
}
