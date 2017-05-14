package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.system.System;

import common.State;

class Menu extends State {
  var items: Array<MenuItem> = new Array<MenuItem>();
  var selectedItem(default, set): MenuItem;

  public function new() {
    super();

    addChild(new Bitmap(Assets.getBitmapData('assets/menu-bg.png')));

    if(Game.instance != null) {
      items.push(new MenuItem("resume", function() {
        Main.instance.setState(Game.instance);
      }));
    }
    items.push(new MenuItem("new-game", function() {
      Main.instance.setState(new Game());
    }));
    items.push(new MenuItem("quit", function() {
      System.exit(0);
    }));

    arrangeItems();
  }

  function arrangeItems() {
    var ny: Float = 20;
    for(item in items) {
      item.y = ny;
      item.x = 380;
      item.addEventListener(MouseEvent.MOUSE_OVER, function(e: MouseEvent) {
        selectedItem = item;
      });
      item.addEventListener(MouseEvent.CLICK, function(e: MouseEvent) {
        item.act();
      });
      addChild(item);

      ny += item.height + 10;
    }
  }

  function set_selectedItem(value: MenuItem): MenuItem {
    for(item in items) {
      item.selected = (item == value);
    }

    return selectedItem = value;
  }
}

