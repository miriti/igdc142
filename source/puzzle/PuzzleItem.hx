package puzzle;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.geom.Rectangle;
import openfl.geom.Point;
import openfl.events.MouseEvent;
import openfl.geom.Point;

class PuzzleItem extends Sprite {
  public var selected(default, set): Bool;
  public var pos: Point = new Point();
  public var removed: Bool = false;
  private var puzzle(get, never): Puzzle;

  public function new() {
    super();

    buttonMode = true;

    addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
    addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
  }

  function get_puzzle(): Puzzle {
    return cast parent;
  } 

  function onMouseOver(e: MouseEvent) {
    if(!puzzle.locked) {
      if(!selected) {
        if(puzzle.previous != null) {
          if(Type.getClassName(Type.getClass(this)) == Type.getClassName(Type.getClass(puzzle.previous))) {
            if(Point.distance(this.pos, puzzle.previous.pos) <= 1) {
              selected = true;
              puzzle.previous = this;
              puzzle.selectedInOrder.push(this);

              var cnt = Math.min(puzzle.getSelected().length, 13) - 1;
              Assets.getSound('assets/snd/pop-' + cnt + '.ogg').play();
            }
          }
        }
      }
    }
  }

  function onMouseDown(e: MouseEvent) {
    if(!puzzle.locked) {
      if(puzzle.previous == null) {
        selected = true;
        puzzle.selectedInOrder.push(this);
        puzzle.previous = this;
        Assets.getSound('assets/snd/pop-0.ogg').play();
      }
    }
  }

  /**
    WARNING: Govnocode
   **/
  public static function random():PuzzleItem {
    var v = [new Fire(), new Health(), new Shield(), new Claw()];
    return v[Math.floor(Math.random() * v.length)];
  }

  function initIcon(num: Int) {
    var data:BitmapData = new BitmapData(16, 16);
    data.copyPixels(
        Assets.getBitmapData('assets/puzzle-icons.png'),
        new Rectangle(num * 16, 0, 16, 16),
        new Point(0, 0)
        );

    addChild(new Bitmap(data));
  }

  function set_selected(value: Bool): Bool {
    this.alpha = value ? 0.8 : 1;
    return selected = value;
  }
}
