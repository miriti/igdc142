package;

import openfl.Assets;

import common.GameSprite;
import common.Anim;

class Enemy extends GameSprite {
  var anim: Anim;
  public function new() {
    super();

    anim = new Anim();
    anim.fromJSON(Assets.getText('assets/anim/enemy.json'), Assets.getBitmapData('assets/anim/enemy.png'));
    anim.playTag = 'idle';
    addChild(anim);
  }
}
