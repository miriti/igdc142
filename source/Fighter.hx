package;

import common.GameSprite;

import openfl.display.Shader;
import openfl.events.Event;
import openfl.filters.ColorMatrixFilter;
import openfl.filters.ShaderFilter;

import motion.Actuate;

class Fighter extends GameSprite {
  var filter:ColorMatrixFilter;
  var bars: Bars;

  public function new() {
    super();

    filter = new ColorMatrixFilter([
        1, 1, 1, 0, 1000, 
        0, 1, 0, 0, 1000, 
        0, 0, 1, 0, 1000, 
        0, 0, 0, 1, 0
    ]);

    bars = new Bars();

    addEventListener(Event.ADDED_TO_STAGE, function(e:Event) {
      initBars();

      Actuate.tween(bars, 1, { hp: 1, dp: 1});
    });
  }

  public function hit() {
    filters = [filter];
  }

  public function initBars() {
    bars.x = width / 2 - bars.width / 2;
    bars.y = -bars.height - 5;
    addChild(bars);
  }
}
