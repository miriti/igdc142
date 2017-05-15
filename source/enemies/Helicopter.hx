package enemies;

import openfl.Assets;

import common.Anim;

class Helicopter extends Enemy {
  var anim: Anim;

  var yphase: Float = 0;
  var xphase: Float = 0;

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
}
