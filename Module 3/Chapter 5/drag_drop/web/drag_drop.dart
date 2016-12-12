import 'dart:html';
import 'dart:math';

void main() {
  var dnd = new DragnDrop();
  dnd.init();
}

class DragnDrop {
  Element dragSource;
  Map tiles;
  var rand = new Random();
  var cols = document.querySelectorAll('.pict');

  void init() {
    generateMap();
    for (var col in cols) {
      col
        ..onDragStart.listen(_onDragStart)
        ..onDragEnd.listen(_onDragEnd)
        ..onDragEnter.listen(_onDragEnter)
        ..onDragOver.listen(_onDragOver)
        ..onDragLeave.listen(_onDragLeave)
        ..onDrop.listen(_onDrop)
        ..style.setProperty("background-image", getRandomTile(), "")
        ..style.setProperty("background-repeat", "no-repeat", "")
        ..style.setProperty("background-position", "center", "");
    }
  }

  void generateMap() {
    tiles = new Map();
    for (var i = 1; i <= 9; i++) {
      tiles[i] = "url(img/tiles_0$i.jpg)";
    }
  }

  void _onDragStart(MouseEvent event) {
    Element dragTarget = event.target;
    dragTarget.classes.add('moving');
    dragSource = dragTarget;
    event.dataTransfer.effectAllowed = 'move';
    // event.dataTransfer.setData('text/html', dragTarget.innerHtml);
  }

  void _onDragEnd(MouseEvent event) {
    Element dragTarget = event.target;
    dragTarget.classes.remove('moving');
    for (var col in cols) {
      col.classes.remove('over');
    }
  }

  void _onDragEnter(MouseEvent event) {
    Element dropTarget = event.target;
    dropTarget.classes.add('over');
  }

  void _onDragOver(MouseEvent event) {
    // This is necessary to allow us to drop.
    event.preventDefault();
    event.dataTransfer.dropEffect = 'move';
  }

  void _onDragLeave(MouseEvent event) {
    Element dropTarget = event.target;
    dropTarget.classes.remove('over');
  }

  void _onDrop(MouseEvent event) {
    // Stop the browser from redirecting in case of hovering over a link.
    event.stopPropagation();
    // Don't do anything if dropping onto the same tile we're dragging.
    Element dropTarget = event.target;
    if (dragSource != dropTarget) {
      var swap_image = dropTarget.style.backgroundImage;
      dropTarget.style.backgroundImage = dragSource.style.backgroundImage;
      dragSource.style.backgroundImage = swap_image;
      // Set the source column's HTML to the HTML of the tile we dropped on.
      // dragSource.innerHtml = dropTarget.innerHtml;
      // dropTarget.innerHtml = event.dataTransfer.getData('text/html');
    }
  }

  String getRandomTile() {
    var num = rand.nextInt(10);
    var imgUrl = tiles[num];
    while (imgUrl == null) {
      num = rand.nextInt(10);
      imgUrl = tiles[num];
    }
    tiles.remove(num);
    return imgUrl;
  }
}