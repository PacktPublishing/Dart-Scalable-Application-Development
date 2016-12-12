part of icacoe;

class SquareGrid extends Grid {
  static const String X = 'X';
  static const String O = 'O';

  int length;

  SquareGrid(int l) : length = l, super(l, l);

  Cell newCell(Grid grid, int row, int column) =>
      new Cell(this, row, column);

  bool lineCompleted() {
    var c;
    var t;
    var line = [];
    // columns
    for (var x = 0; x < length; x++) {
      line = [];
      for (var y = 0; y < length; y++) {
        c = cell(x, y);
        t = c.text;
        line.add(t);
      }
      if (_completed(line)) return true;
    }
    // rows
    for (var y = 0; y < length; y++) {
      line = [];
      for (var x = 0; x < length; x++) {
        c = cell(x, y);
        t = c.text;
        line.add(t);
      }
      if (_completed(line)) return true;
    }
    // diagonal: \
    line = [];
    for (var d = 0; d < length; d++) {
      c = cell(d, d);
      t = c.text;
      line.add(t);
    }
    if (_completed(line)) return true;
    // diagonal: /
    line = [];
    var y = length - 1;
    for (var x = 0; x < length; x++) {
      c = cell(x, y);
      t = c.text;
      line.add(t);
      y--;
    }
    if (_completed(line)) return true;
    return false;
  }

  bool _completed(List line) =>
      line.every((t) => t != null && t == X) ||
      line.every((t) => t != null && t == O);
}