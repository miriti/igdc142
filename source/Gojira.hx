package;

import openfl.Assets;

import motion.Actuate;
import motion.easing.*;

import common.GameSprite;
import common.Anim;

class Gojira extends GameSprite {
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
  }

  public function action(type: String, times: Int, callback: Void -> Void) {
    if(type== 'fire') {
      anim.playTag = 'Fire';

      fired = 0;
      this.times = times;

      genFire(callback);
    } else {
      callback();
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
