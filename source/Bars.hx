package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

class Bars extends Sprite {
  public var hp(default, set): Float = 0;
  public var dp(default, set): Float = 0;

  var bars = new Sprite();
  var hpbar:Bitmap;
  var dpbar:Bitmap;

  public function new() {
    super();

    hpbar = new Bitmap(Assets.getBitmapData('assets/hp-bar.png'));
    dpbar = new Bitmap(Assets.getBitmapData('assets/dp-bar.png'));
    dpbar.y = hpbar.height;
    dpbar.visible = false;

    addChild(hpbar);
    addChild(dpbar);
    addChild(bars);
  }

  private function _draw() {
    var hp_width:Int = Std.int(70.0 * hp);
    var dp_width:Int = Std.int(70.0 * dp);

    bars.graphics.clear();
    if(hp > 0) {
      bars.graphics.beginFill(0xd45f48);
      bars.graphics.drawRect(12, 2, hp_width, 5);
    }

    if(dp > 0) {
      bars.graphics.beginFill(0x6d71f9);
      bars.graphics.drawRect(12, 10, dp_width, 5);
    }
    bars.graphics.endFill();
  }

  function set_hp(value: Float): Float {
    hp = value;
    _draw();
    return hp;
  }

  function set_dp(value: Float): Float { 
    dp = value;
    dpbar.visible = (value > 0);
    _draw();
    return dp;
  }
}
