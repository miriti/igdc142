package puzzle;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import motion.Actuate;
import motion.easing.*;

class Puzzle extends Sprite {
  public var previous: PuzzleItem = null;
  public var locked: Bool = false;
  public var selectedInOrder: Array<PuzzleItem> = [];

  var items:Array<Array<PuzzleItem>> = [
    [null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null],
    [null, null, null, null, null, null, null, null]
  ];


  public function new() {
    super();
    var _mask = new Bitmap(new BitmapData(8*16, 8*16, false, 0xffffffff));
    mask = _mask;
    addChild(_mask);

    for(i in 0...8) {
      for(j in 0...8) {
        var item = PuzzleItem.random();
        item.x = i * 16;
        item.y = j * 16;
        item.pos.x = i;
        item.pos.y = j;
        items[i][j] = item;
        addChild(item);
      }
    }
    addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
  }

  public function getSelected():Array<PuzzleItem> {
    var result:Array<PuzzleItem> = [];
    for(col in items) {
      for(item in col) {
        if(item != null) {
          if(item.selected) {
            result.push(item);
          }
        }
      }
    }
    return result;
  }

  function solved() {
    var selected = getSelected();

    if(selected.length >= 3) {
      var fill = function() {
        for(col in 0...8) {
          var row = 7;
          var gap = 0;

          while(row >= 0) {
            if(items[col][row] == null) {
              gap++;
              row--;
            } else {
              if(gap > 0) {
                var item = items[col][row];
                var ny = row + gap;

                item.pos.y = ny;

                Actuate.tween(item, 0.5 * gap, {y: ny*16}).ease(Bounce.easeOut);

                items[col][row] = null;
                items[col][ny] = item;

                row = 7;
                gap = 0;

                continue;
              } else {
                row--;
              }
            }
          }


          var new_count = 0;
          for(i in 0...8) {
            if(items[col][i] == null) {
              new_count++;
            }
          }

          for(i in 0...8) {
            if(items[col][i] == null) {
              var newItem = PuzzleItem.random();

              newItem.x = col * 16;
              newItem.y = -16 * new_count + i * 16;
              newItem.pos.x = col;
              newItem.pos.y = i;

              Actuate.tween(newItem, 1, { y: i * 16 }).ease(Bounce.easeOut).delay(0.5);

              addChild(newItem);

              items[col][i] = newItem;
            }
          }
        }

      };

      locked = true;

      var itemNumber = 0;
      var used = 0;
      var total = selectedInOrder.length;

      for(item in selectedInOrder) {
        if(item != null) {
          if(item.selected) {
            Actuate.timer((itemNumber++) / 15).onComplete(function() {

              var itemGlobalPos = item.getBounds(Game.instance);
              var gojiraGlobalPos = Game.instance.gojira.getBounds(Game.instance);

              removeChild(item);
              item.x = itemGlobalPos.x;
              item.y = itemGlobalPos.y;

              Game.instance.addChild(item);

              Actuate.tween(item, 0.75, { 
                x: gojiraGlobalPos.x + Game.instance.gojira.width / 2 + (-10 + Math.random() * 20),
                y: gojiraGlobalPos.y + Game.instance.gojira.height / 3 + (-10 + Math.random() * 20)
              }).ease(Sine.easeOut).onComplete(function() {
                Game.instance.removeChild(item);
                Assets.getSound('assets/snd/pop-use.ogg').play();
                if(++used == total) {

                  var item:PuzzleItem = selectedInOrder[0];

                  var action: String = '';

                  if(Std.is(item, Fire)) {
                    action = 'fire';
                  }

                  if(Std.is(item, Health)) {
                    action = 'health';
                  }

                  if(Std.is(item, Shield)) {
                    action = 'shield';
                  }

                  Game.instance.gojira.action(action, total, function() {
                    fill();
                    selectedInOrder = [];
                    locked = false;
                  });
                }
              });

              Assets.getSound('assets/snd/pop-solved.ogg').play();
            });
            items[Std.int(item.pos.x)][Std.int(item.pos.y)] = null;
          }
        }
      }
    }
  }

  function onMouseUp(e: MouseEvent) {
    solved();
    unselectAll();
  }

  public function unselectAll() {
    previous = null;
    for(col in items) {
      for(item in col) {
        if(item != null) {
        item.selected = false;
        }
      }
    }
  }
}
