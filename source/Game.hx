package;

import common.Anim;
import openfl.Assets;
import puzzle.Puzzle;
import enemies.Enemy;

class Game extends common.State {
  public static var instance: Game = null;

  public var scrolling: Bool = false;

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

    enemy = new enemies.Helicopter();
    enemy.x = 300 - enemy.width;
    enemy.y = 75;
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
    super.update(delta);

    if(scrolling) {
      bg.scrollX -= 100 * delta;
    }
  }

  public function nextEnemy() {
    enemy.parent.removeChild(enemy);
    scrolling = true;
  }
}
