package;

import common.GameSprite;

import openfl.display.Shader;
import openfl.events.Event;
import openfl.filters.ColorMatrixFilter;
import openfl.filters.ShaderFilter;

import motion.Actuate;

class Fighter extends GameSprite {
  public var health(default, set): Float = 0;
  public var dp(default, set): Float = 0;

  var filter:ColorMatrixFilter;
  var bars: Bars;
  var maxHealth: Float = 100;
  var maxDP: Float = 100;

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
    });
  }

  public function hit(amount: Float) {
    if(dp == 0) {
      health -= amount;
    } else {
      dp -= (amount * 2);
    }
  }

  public function initBars() {
    bars.x = width / 2 - bars.width / 2;
    bars.y = -bars.height - 5;
    addChild(bars);
  }

  function set_dp(value: Float): Float {
    if(value < 0) value = 0;
    if(value > maxDP) value = maxDP;
    Actuate.tween(bars, 1, { dp: value / maxDP });
    return dp = value;
  }

  function set_health(value: Float): Float {
    if(value < 0) value = 0;
    if(value > maxHealth) value = maxHealth;
    Actuate.tween(bars, 1, { hp: value / maxHealth });
    return health = value;
  }
}
