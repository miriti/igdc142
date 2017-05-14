package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.display.StageQuality;

import common.StateMachine;
import common.State;

class Main extends StateMachine {
  public static var instance: Main;

	public function new () {
		super ();
    instance = this;

    Lib.current.stage.quality = StageQuality.LOW;
    State.target_height = 200;
    State.target_width = 460;

    setState(new Menu());
	}
}
