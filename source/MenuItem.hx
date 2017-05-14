package;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.display.Bitmap;
import openfl.Assets;

class MenuItem extends Sprite {
  public var selected(default, set): Bool;

  var bitmap: Bitmap;
  var action: Void -> Void;

  public function new(asset: String, action: Void -> Void) {
    super();

    bitmap = new Bitmap(Assets.getBitmapData('assets/menu/' + asset + '.png'));
    bitmap.x = -bitmap.width / 2;
    bitmap.y = -bitmap.height / 2;
    addChild(bitmap);

    alpha = 0.8;
    buttonMode = true;
    this.action = action;
  }

  public function set_selected(value: Bool): Bool {
    alpha = value ? 1 : 0.8;
    return selected = value;
  }

  public function act() {
    openfl.Lib.current.stage.focus = openfl.Lib.current.stage;
    if(action != null) {
      action();
    }
  }
}
