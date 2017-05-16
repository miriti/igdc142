package;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.Bitmap;

import common.Scrolling;

class GameBg extends Sprite {
  var ruinsbg: Scrolling;
  var sky0: Scrolling;
  var sky1: Scrolling;
  var sky2: Scrolling;
  var sky3: Scrolling;
  var sky4: Scrolling;
  var cityStreet: Scrolling;

  public var scrollX(default, set):Float = 0;

  public function new() {
    super();
    sky0 = new Scrolling([
        new Bitmap(Assets.getBitmapData('assets/sky0.png')),
        new Bitmap(Assets.getBitmapData('assets/sky0.png')),
        new Bitmap(Assets.getBitmapData('assets/sky0.png')),
    ]);
    addChild(sky0);

    sky1 = new Scrolling([
        new Bitmap(Assets.getBitmapData('assets/sky1.png')),
        new Bitmap(Assets.getBitmapData('assets/sky1.png')),
        new Bitmap(Assets.getBitmapData('assets/sky1.png')),
    ]);
    addChild(sky1);

    sky2 = new Scrolling([
        new Bitmap(Assets.getBitmapData('assets/sky2.png')),
        new Bitmap(Assets.getBitmapData('assets/sky2.png')),
        new Bitmap(Assets.getBitmapData('assets/sky2.png')),
    ]);
    addChild(sky2);

    sky3 = new Scrolling([
        new Bitmap(Assets.getBitmapData('assets/sky3.png')),
        new Bitmap(Assets.getBitmapData('assets/sky3.png')),
        new Bitmap(Assets.getBitmapData('assets/sky3.png')),
    ]);
    addChild(sky3);

    sky4 = new Scrolling([
        new Bitmap(Assets.getBitmapData('assets/sky4.png')),
        new Bitmap(Assets.getBitmapData('assets/sky4.png')),
        new Bitmap(Assets.getBitmapData('assets/sky4.png')),
    ]);
    addChild(sky4);

    ruinsbg = new Scrolling([
        new Bitmap(Assets.getBitmapData('assets/ruins_bg.png')),
        new Bitmap(Assets.getBitmapData('assets/ruins_bg.png')),
        new Bitmap(Assets.getBitmapData('assets/ruins_bg.png'))
    ]);
    addChild(ruinsbg);

    cityStreet = new Scrolling([
        new Bitmap(Assets.getBitmapData('assets/city_street.png')),
        new Bitmap(Assets.getBitmapData('assets/city_street.png')),
        new Bitmap(Assets.getBitmapData('assets/city_street.png'))
    ]);

    addChild(cityStreet);
  }

  function set_scrollX(value: Float):Float {
    scrollX = value;
    sky0.scrollX = scrollX / 12;
    sky1.scrollX = scrollX / 10;
    sky2.scrollX = scrollX / 8;
    sky3.scrollX = scrollX / 6;
    sky4.scrollX = scrollX / 4;
    ruinsbg.scrollX = scrollX / 2;
    cityStreet.scrollX = scrollX;

    return scrollX;
  }
}
