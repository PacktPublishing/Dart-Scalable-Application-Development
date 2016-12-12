part of memory;

class Board extends Surface {
  num cellSize;
  Memory memory;
  MemoryCell lastCellClicked;

  Board(Memory memory, CanvasElement canvas) : this.memory = memory,
      super(memory, canvas) {
    cellSize = canvas.width / memory.length; // in pixels
    querySelector('#canvas').onMouseDown.listen((MouseEvent e) {
      int row = (e.offset.y ~/ cellSize).toInt();
      int column = (e.offset.x ~/ cellSize).toInt();
      MemoryCell cell = memory.cell(row, column);
      cell.hidden = false;
      if (cell.twin == lastCellClicked) {
        lastCellClicked.hidden = false;
        if (memory.recalled) { // game over
          new Timer(const Duration(milliseconds: 5000), () => memory.hide());
        }
      } else if (cell.twin.hidden) {
        new Timer(const Duration(milliseconds: 800), () => cell.hidden = true);
      }
      lastCellClicked = cell;
    });
    window.animationFrame.then(gameLoop);
  }

  void gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
  }

  void draw() {
    super.draw();
    if (memory.recalled) { // game over
      context.font = 'bold 25px sans-serif';
      context.fillStyle = 'red';
      context.fillText('YOU WIN', cellSize, cellSize * 2);
    }
  }
}
