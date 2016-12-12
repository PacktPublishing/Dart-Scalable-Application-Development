part of boarding;

class Surface {
  num width, height; // in pixels

  Grid grid;
  bool withLines;

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  Surface(this.grid, this.canvas, {this.withLines: true}) {
    context = canvas.getContext("2d");
    width = canvas.width;
    height = canvas.height;
  }

  clear() {
    new Rect(this, 0, 0, width, height).draw();
  }

  lines() {
    var wgap = width / grid.width;
    var hgap = height / grid.height;
    var x, y;
    for (var row = 1; row < grid.height; row++) {
      x = 0;
      y = hgap * row;
      new Line(this, x, y, x + width, y).draw();
    }
    for (var col = 1; col < grid.width; col++) {
      x = wgap * col;
      y = 0;
      new Line(this, x, y, x, y + height).draw();
    }
  }

  cells() {
    var wgap = width / grid.width;
    var hgap = height / grid.height;
    var cells = grid.cells;
    for (Cell cell in cells) {
      var row = cell.row;
      var col = cell.column;
      if (cell.hidden) {
        var x = wgap * col;
        var y = hgap * row;
        new Rect(this, x, y, wgap, hgap,
            inColor: colorMap()[cell.hiddenColor]).draw();
        var cx = x + wgap / 2;
        var cy = y + hgap / 2;
        var r = 4;
        new Circle(this, cx, cy, r).draw();
      } else {
        if (cell.color != null) {
          var x = wgap * col;
          var y = hgap * row;
          new Rect(this, x, y, wgap, hgap,
              inColor: colorMap()[cell.color]).draw();
        }
        if (cell.text != null && cell.textSize != null) {
          var x = wgap * col + wgap / 2 - (wgap / 2 - cell.textSize) / 2;
          var y = hgap * row + hgap / 2 + (wgap / 2 - cell.textSize) / 2;
          new Tag(this, cell.text, x, y,
            size: cell.textSize, color: cell.textColor).draw();
        }
      }
    }
  }

  draw() {
    clear();
    if (withLines) lines();
    cells();
  }
}