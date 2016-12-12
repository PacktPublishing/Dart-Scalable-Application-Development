library icacoe;

import 'dart:html';
import 'package:boarding/boarding_model.dart';
import 'package:boarding/boarding.dart';

part 'model/square_grid.dart';
part 'view/board.dart';

main() {
  // model
  var grid = new SquareGrid(3);
  // view
  new Board(grid, querySelector('#canvas')).draw();
}


