package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

import puzzle.Puzzle;

class PuzzlePanel extends Sprite {
  private var puzzle: Puzzle;

  public function new() {
    super();
    addChild(new Bitmap(Assets.getBitmapData('assets/puzzle-bg.png')));

    puzzle = new Puzzle();
    puzzle.x = (width - puzzle.width) / 2;
    puzzle.y = (height - puzzle.height) / 2;
    addChild(puzzle);
  }
}
