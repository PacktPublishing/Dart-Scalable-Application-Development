main() {
  List<List<int>> matrix = new List<List<int>>();
  for (var i = 0; i < 10; i++) {
    List<int> list = new List<int>();

    for (var j = 0; j < 10; j++) {
      list.add(j);
    }

    matrix.add(list);
  }

  print(matrix);
  print(matrix[2][4]);

  var flat = matrix.expand((i) => i).toList();
  print(flat);
}