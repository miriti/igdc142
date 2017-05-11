package common;

import openfl.display.DisplayObject;
import openfl.display.Sprite;

class Scrolling extends Sprite {
  public var scrollX(default, set): Float;

  var samples:Array<DisplayObject>;

  public function new(samples: Array<DisplayObject>) {
    super();
    this.samples = samples;

    for(s in samples) {
      addChild(s);
    }
    scrollX = 0;
  }

  function set_scrollX(value: Float): Float {
    var nx:Float = 0;

    while(value <= -samples[0].width) {
      value += samples[0].width;
    }

    scrollX = value;

    for(sample in samples) {
      sample.x = scrollX + nx;

      nx += sample.width;
    }
    return scrollX;
  }
}
