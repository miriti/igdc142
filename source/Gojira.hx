package;

import openfl.Assets;

import motion.Actuate;
import motion.easing.*;

import common.GameSprite;
import common.Anim;

import puzzle.*;

class Gojira extends Fighter {
  var anim: Anim;
  var fired = 0;
  var times = 0;

  public function new() {
    super();

    anim = new Anim();
    anim.fromJSON(
        Assets.getText("assets/anim/gojira.json"), 
        Assets.getBitmapData("assets/anim/gojira.png")
        );
    anim.playTag = 'idle';
    addChild(anim);

    health = 100;
  }

  public function pickup(item: PuzzleItem) {
    if(Std.is(item, Shield)) {
      dp += 2;
    }

    if(Std.is(item, Health)) {
      health += 2;
    }
  }

  public function afterEnemyResponse(callback: Void -> Void) {
    if(Game.instance.enemy.health > 0) {
      callback();
    } else {
      anim.playTag = 'walking';
      Game.instance.nextEnemy();
    }
  }

  public function action(type: String, times: Int, callback: Void -> Void) {
    if(type== 'fire') {
      anim.playTag = 'Fire';

      fired = 0;
      this.times = times;

      genFire(function() {
        Game.instance.enemy.respond(function() {
          afterEnemyResponse(callback);
        });
      });
    } else {
      Game.instance.enemy.respond(function() {
        afterEnemyResponse(callback);
      });
    }
  }

  function genFire(callback:Void -> Void) {
    var fire = new Anim();
    fire.fromJSON(Assets.getText('assets/anim/fire.json'), Assets.getBitmapData('assets/anim/fire.png'));
    Assets.getSound('assets/snd/fire.ogg').play();
    fire.x = x + 93;
    fire.y = y + 17;

    parent.addChild(fire);

    Actuate.tween(fire, 0.5, {
      x: fire.x + 100, 
    }).ease(Linear.easeNone).onComplete(function() {
      Game.instance.enemy.hit(1);
      parent.removeChild(fire);
    });

    if(++fired == times) {
      Actuate.timer(0.5).onComplete(function() {
        anim.playTag = 'idle';
        callback();
      });
    } else {
      Actuate.timer(0.15).onComplete(function() {
        genFire(callback);
      });
    }
  }

}
