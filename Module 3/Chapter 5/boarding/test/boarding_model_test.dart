import 'package:unittest/unittest.dart';
import 'package:boarding/boarding_model.dart';

testModel(Grid grid) {
  group('Testing model', () {
    var w = grid.width;
    var h = grid.height;
    setUp(() {
      expect(grid, isNotNull);
      expect(w, greaterThan(1));
      expect(h, greaterThan(1));
      expect(grid.cells.every((c) => c.text == 'empty'), isTrue);
    });
    tearDown(() {
      for (Cell cell in grid.cells) {
        cell.text = 'empty';
      }
    });
    test('Cell', () {
      Cell cell = grid.cell(h - 1, w - 1);
      expect(cell, isNotNull);
      expect(cell.row, equals(h - 1));
      expect(cell.column, equals(w - 1));
      expect(cell.textSize, isNull);
      expect(cell.textColor, isNull);
    });
    test('Some cells are red', () {
      Cell cell = grid.cell(h - 1, w - 1);
      cell.textColor = 'red';
      expect(grid.cells.any((c) => c.textColor == 'red'), isTrue);
    });
    test('Cell intersection', () {
      Cell cell = grid.cell(h - 1, w - 1);
      expect(cell.intersects(h - 1, w - 1), isTrue);
      expect(cell.intersects(0, 0), isFalse);
    });
    test('Cell intersection exception', () {
      Cell cell = grid.cell(h - 1, w - 1);
      expect(() => cell.intersects(h - 1, w), throws);
    });
  });
}

main() {
  var grid = new Grid(16, 20);
  for (Cell cell in grid.cells) {
    cell.text = 'empty';
  }
  testModel(grid);
}
