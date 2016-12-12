String str = "Hello";

void main() {
  print(rot13(str)); // Uryyb
}

String rot13(String s) {
  List<int> rotated = [];

  s.codeUnits.forEach((charCode) {
    final int numLetters = 26;
    final int A = 65;
    final int a = 97;
    final int Z = A + numLetters;
    final int z = a + numLetters;

    if (charCode < A ||
        charCode > z ||
        charCode > Z && charCode < a) {
      rotated.add(charCode);
    }
    else {
      if ([A, a].any((item){
        return item <= charCode && charCode < item + 13;
      })) {
        rotated.add(charCode + 13);
      } else {
        rotated.add(charCode - 13);
      }
    }
  });
  return (new String.fromCharCodes(rotated));
}
