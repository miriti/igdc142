package enemies;

class Enemy extends Fighter {
  public function new() {
    super();
  }

  public function respond(callback: Void -> Void) {
    callback();
  }
}
