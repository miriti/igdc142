package;

import common.Anim;
import openfl.Assets;
import puzzle.Puzzle;

class Game extends common.State {
  public static var instance: Game = null;

  public var gojira: Gojira;
  public var enemy: Enemy;

  var bg:GameBg;
  var puzzlePanel: PuzzlePanel;

  public function new() {
    super();

    instance = this;

    bg = new GameBg();
    addChild(bg);

    gojira = new Gojira();
    gojira.x = 130 - gojira.width;
    gojira.y = 200 - gojira.height - 30;
    addChild(gojira);

    enemy = new Enemy();
    enemy.x = 320 - enemy.width;
    enemy.y = 200 - enemy.height - 30;
    addChild(enemy);

    puzzlePanel = new PuzzlePanel();
    puzzlePanel.x = 460 - puzzlePanel.width;
    addChild(puzzlePanel);
  }

  override function keyDown(keycode: Int) {
    if(keycode == openfl.ui.Keyboard.ESCAPE) {
      Main.instance.setState(new Menu());
    }
  }

  override function update(delta: Float) {
  }
}
