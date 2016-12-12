import 'dart:math';

Random rnd = new Random();
var lst = ['Bill','Joe','Jennifer','Louis','Samantha'];

void main() {
  var element = lst[rnd.nextInt(lst.length)];
  print(element); // e.g. 'Louis'
  element = randomListItem(lst);
  print(element); // e.g. 'Samantha'
}

randomListItem(List lst) => lst[rnd.nextInt(lst.length)];