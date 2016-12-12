part of memory;

class MemoryCell extends Cell {
  MemoryCell twin;

  MemoryCell(Memory memory, int row, int column) : super(memory, row, column);
}

class Memory extends Grid {
  static const String HIDDEN_CELL_COLOR = 'lightgray';

  int length;
  bool _recalled = false;

  Memory(int l) : length = l, super(l, l) {
    if (length.isOdd) {
      throw new Exception('Memory length must be an even integer: $l.');
    }
    for (MemoryCell mc in cells) {
      mc.hidden = true;
      mc.hiddenColor = HIDDEN_CELL_COLOR;
      if (mc.color == null) {
        mc.color = getFreeRandomColor();
        _setFreeTwinRandomCell(mc);
      }
    }
  }

  Cell newCell(Grid grid, int row, int column) =>
      new MemoryCell(this, row, column);

  _setFreeTwinRandomCell(MemoryCell mc) {
    if (mc.twin == null) {
      var row;
      var column;
      while (cells.any((c) => c.twin == null)) {
        row = randomInt(length);
        column = randomInt(length);
        MemoryCell tc = cell(row, column);
        if (tc.twin == null && (tc.row != mc.row || tc.column != mc.column)) {
          mc.twin = tc;
          tc.twin = mc;
          tc.color = mc.color;
          break;
        }
      }
    }
  }

  bool get recalled {
    if (!_recalled) {
      if (cells.every((c) => c.shown)) _recalled = true;
    }
    return _recalled;
  }

  hide() {
    for (final cell in cells) cell.hidden = true;
    _recalled = false;
  }
}