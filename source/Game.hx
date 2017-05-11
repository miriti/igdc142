package;

import common.Anim;
import openfl.Assets;
import puzzle.Puzzle;

class Game extends common.State {
  var bg:GameBg;

  var gojira: Anim;

  public function new() {
    super();

    bg = new GameBg();
    addChild(bg);

    gojira = new Anim();
    gojira.fromJSON(
        Assets.getText("assets/anim/gojira.json"), 
        Assets.getBitmapData("assets/anim/gojira.png")
        );
    gojira.x = 160 - gojira.width;
    gojira.y = 200 - gojira.height - 30;
    gojira.playTag = 'walking';
    addChild(gojira);

    var puzzle = new Puzzle();
    puzzle.x = 480 - puzzle.width - 20;
    puzzle.y = 20;

    addChild(puzzle);
  }

  override function update(delta: Float) {
    bg.scrollX -= 90 * delta;
  }
}
