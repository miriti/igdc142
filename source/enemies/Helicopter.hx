package enemies;

import openfl.Assets;

import common.Anim;

import motion.Actuate;
import motion.easing.*;

class Helicopter extends Enemy {
  var anim: Anim;

  var yphase: Float = 0;
  var xphase: Float = 0;

  var bullets: Int;

  public function new() {
    super();

    anim = new Anim();
    anim.fromJSON(
        Assets.getText('assets/anim/helicopter.json'), 
        Assets.getBitmapData('assets/anim/helicopter.png')
        );
    anim.playTag = 'fly';
    addChild(anim);

    initBars();

    maxHealth = 25;
    health = 100;
  }

  override function update(delta: Float) {
    super.update(delta);

    anim.y = Math.sin(yphase) * 8;
    anim.x = Math.sin(xphase) * 3;

    bars.x = anim.x + anim.width / 2 - bars.width/2;
    bars.y = anim.y - bars.height - 5;

    yphase += (Math.PI / 2) * delta;
    xphase += (Math.PI / 3) * delta;
  }

  override public function respond(callback: Void -> Void) {
    if(health > 0) {
      bullets = 2 + Math.floor(Math.random() * 10);
      Actuate.timer(0.5).onComplete(function() {
        genBullet(callback);
      });
    } else {
      callback();
    }
  }

  function genBullet(callback: Void -> Void) {
    var bullet = new Bullet();

    bullet.x = x + anim.x;
    bullet.y = y + anim.y + 26;

    parent.addChild(bullet);

    Assets.getSound('assets/snd/shot.ogg').play();

    Actuate.tween(bullet, 0.5, { x: bullet.x - 100 }).ease(Linear.easeNone).onComplete(function() {
      parent.removeChild(bullet);
      Game.instance.gojira.hit(1);
    });

    Actuate.timer(0.1).onComplete(function() {
      if(--bullets == 0) {
        callback();
      } else {
        genBullet(callback);
      }
    });
  }
}
