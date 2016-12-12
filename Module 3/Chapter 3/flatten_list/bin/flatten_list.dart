List lst = [[1.5, 3.14, 45.3], ['m', 'pi', '7'], [true, false, true]];
// flattening lst must give the following resulting List flat:
// [1.5, 3.14, 45.3, m, pi, 7, true, false, true]

void main() {
  // 1- using forEach and addAll:
  var flat = [];
  lst.forEach((e) => flat.addAll(e));
  print(flat);
  // 2- using Iterable.expand:
  flat = lst.expand((i) => i).toList();
  // 3- more nesting levels, work recursively:
  lst = [[1.5, 3.14, 45.3], ['m', 'pi', '7'], "Dart", [true, false, true]];
  print(flatten(lst));

}

Iterable flatten(Iterable iterable)
  => iterable.expand((e) => e is List ? flatten(e) : [e]);