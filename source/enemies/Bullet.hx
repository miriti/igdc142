package enemies;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.Bitmap;

class Bullet extends Sprite {
  public function new() {
    super();
    addChild(new Bitmap(Assets.getBitmapData('assets/bullet.png')));
  }
}
