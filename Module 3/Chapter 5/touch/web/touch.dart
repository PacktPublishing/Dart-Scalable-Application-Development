import 'dart:html';
import 'dart:math';

void main() {
  var touch = new Touch();
  touch.init();
}

class Touch {
  Element dragSource;
  Map tiles;
  var rand = new Random();
  var cols = document.querySelectorAll('.pict');

  void init() {
    generateMap();
    for (var col in cols) {
      col
        ..onTouchStart.listen(_onTouchStart)
        ..onTouchEnd.listen(_onTouchEnd)
        ..onTouchMove.listen(_onTouchMove)
        ..style.setProperty("background-image", getRandomTile(), "")
        ..style.setProperty("background-repeat", "no-repeat", "")
        ..style.setProperty("background-position", "center", "");
    }
  }

  void _onTouchStart(TouchEvent event) {
    event.preventDefault(); //stop scrolling by default
    Element dragTarget = event.target; //capture drag target
    //add style to element to indicate its moving
    dragTarget.classes.add('moving');
    dragSource = dragTarget;
  }

  void _onTouchMove(TouchEvent event) {
    event.preventDefault();
    Element dropTarget = event.target;
    dragSource.classes.add('moving');
    //Get the current x,y position of the first finger touch and find the element it is over
    dropTarget = document.elementFromPoint(event.touches[0].page.x, event.touches[0].page.y);
    // If the finger is over an element indicate that in the UI
    if (dropTarget != null) {
      dropTarget.classes.add('over');
    }
  }

  void _onTouchEnd(TouchEvent event) {
    event.stopPropagation();
    event.preventDefault();
    // Don't do anything if dropping onto the same tile we're dragging.
    Element dropTarget = event.target;
    if (dragSource != dropTarget) {
      var swap_image = dropTarget.style.backgroundImage;
      dropTarget.style.backgroundImage = dragSource.style.backgroundImage;
      dragSource.style.backgroundImage = swap_image;
    }
  }

  void generateMap() {
    tiles = new Map();
    tiles[1] = "url(img/tiles_01.jpg)";
    tiles[2] = "url(img/tiles_02.jpg)";
    tiles[3] = "url(img/tiles_03.jpg)";
    tiles[4] = "url(img/tiles_04.jpg)";
    tiles[5] = "url(img/tiles_05.jpg)";
    tiles[6] = "url(img/tiles_06.jpg)";
    tiles[7] = "url(img/tiles_07.jpg)";
    tiles[8] = "url(img/tiles_08.jpg)";
    tiles[9] = "url(img/tiles_09.jpg)";
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