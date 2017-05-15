package common;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;
import openfl.geom.Rectangle;

typedef AnimationFrame = {
  bitmapData: BitmapData,
  duration: Float
}

typedef AnimationTag = {
  name: String,
  from: Int,
  to: Int,
  direction: String
}

class Anim extends Bitmap {
  public var currentFrame(default, set): Int;
  public var playTag(default, set): String;
  public var fps: Int = 25;

  private var frames:Array<AnimationFrame> = [];
  private var lastTime: Float = 0;
  private var frameTime: Float = 0;

  private var tag: AnimationTag = null;
  private var tags: Map<String, AnimationTag> = new Map<String, AnimationTag>();

  public function new () {
    super();
    addEventListener(Event.ENTER_FRAME, onEnterFrame);
  }

  public function simple(bitmapData: BitmapData, frameWidth: Int, frameHeight: Int, fps: Int = 25) {
    this.fps = fps;

    for(n in 0...Std.int(bitmapData.width / frameWidth)) {
      var frame = new BitmapData(frameWidth, frameHeight);
      frame.copyPixels(bitmapData, new Rectangle(n * frameWidth, 0, frameWidth, frameHeight), new Point(0, 0));
      frames.push({
        bitmapData: frame,
        duration: 1000 / fps
      });
    }

    currentFrame = 0;
  }

  function onEnterFrame(e: Event) {
    if(lastTime != 0) {
      var currentTime = Date.now().getTime(); 
      var delta = currentTime - lastTime;

      frameTime += delta;

      while(frameTime >= frames[currentFrame].duration) {
        currentFrame++;
        frameTime = frameTime - frames[currentFrame].duration;
      }

      lastTime = currentTime;
    } else {
      lastTime = Date.now().getTime();
    }
  }

  function set_currentFrame(frame: Int): Int {
    if(frame > tag.to) {
      frame = tag.from;
    }

    bitmapData = frames[frame].bitmapData;

    return currentFrame = frame;
  }

  public function fromJSON(json: String, bitmapData: BitmapData) {
    var data = haxe.Json.parse(json);

    var jframes: Array<Dynamic> = data.frames;

    for(jframe in jframes) {
      var bmp = new BitmapData(
          Std.parseInt(jframe.frame.w), 
          Std.parseInt(jframe.frame.h)
      );

      bmp.copyPixels(bitmapData, new Rectangle(
            Std.parseInt(jframe.frame.x), 
            Std.parseInt(jframe.frame.y), 
            Std.parseInt(jframe.frame.w), 
            Std.parseInt(jframe.frame.h)
            ), new Point(0, 0));

      frames.push({
        bitmapData: bmp,
        duration: Std.parseInt(jframe.duration)
      });
    }

    tags.set('[full]', {
      name: '[full]',
      from: 0,
      to: frames.length - 1,
      direction: 'forward'
    });

    var frameTags: Array<Dynamic> = data.meta.frameTags;

    for(ftag in frameTags) {
      tags.set(ftag.name, ftag);
    }

    playTag = '[full]';
  }

  function set_playTag(value: String) {
    if(tags.exists(value)) {
      playTag = value;

      tag = tags.get(playTag);
      currentFrame = tag.from;
    }

    return playTag;
  }
}
