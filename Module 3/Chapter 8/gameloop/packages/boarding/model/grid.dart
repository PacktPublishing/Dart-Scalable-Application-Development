part of boarding_model;

class Grid {
  int width;  // in columns
  int height; // in rows

  var cells = new Cells();

  Grid(this.width, this.height) {
    var cell;
    for (var row = 0; row < height; row++) {
      for (var column = 0; column < width; column++) {
        cell = newCell(this, row, column);
        cells.add(cell);
      }
    }
  }

  Cell newCell(Grid grid, int row, int column) {
    return new Cell(grid, row, column);
  }

  Cell cell(int row, int column) {
    if (0 <= row && row < height && 0 <= column && column < width) {
      for (Cell cell in cells) {
        if (cell.intersects(row, column)) return cell;
      }
    } else throw new Exception(
        'cell out of grid - row: $row, column: $column');
    return null;
  }
}