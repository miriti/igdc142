package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

class Bars extends Sprite {
  public var hp(default, set): Float;
  public var dp(default, set): Float;

  var bars = new Sprite();

  public function new() {
    super();

    addChild(new Bitmap(Assets.getBitmapData('assets/bars.png')));
    addChild(bars);
  }

  private function _draw() {
    var hp_width:Int = Std.int(70.0 * hp);
    var dp_width:Int = Std.int(70.0 * dp);

    bars.graphics.clear();
    bars.graphics.beginFill(0xd45f48);
    bars.graphics.drawRect(12, 2, hp_width, 5);
    bars.graphics.beginFill(0x6d71f9);
    bars.graphics.drawRect(12, 10, dp_width, 5);
    bars.graphics.endFill();
  }

  function set_hp(value: Float): Float {
    hp = value;
    _draw();
    return hp;
  }

  function set_dp(value: Float): Float { 
    dp = value;
    _draw();
    return dp;
  }
}
