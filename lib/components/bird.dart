import 'dart:async';

import 'package:flame/components.dart';

class Bird extends SpriteComponent {
  /*

 INIT BIRD

 */

  // initialize bird position and size
  Bird() : super(position: Vector2(100, 100), size: Vector2(60, 40));

  // pyshical world properties
  double velocity = 0;
  final double gravity = 800;
  final double jumpStrength = -300;

  /*

  LOAD

  */

  @override
  Future<void> onLoad() async {
    // load bird sprite image
    sprite = await Sprite.load('bluebird-midflap.png');
  }

  /* 

  JUMP / FLAP

  */

  void flap() {
    velocity = jumpStrength;
  }

  /*

  UPDATE -> every second 

  */

  @override
  void update(double dt) {
    position.y += velocity * dt;
  }
}
