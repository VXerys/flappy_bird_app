import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird_app/components/ground.dart';
import 'package:flappy_bird_app/components/pipe.dart';
import 'package:flappy_bird_app/constants.dart'
    show birdHeight, birdStartX, birdStartY, birdWidth, gravity, jumpStrength;
import 'package:flappy_bird_app/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  /*

 INIT BIRD

 */

  // initialize bird position and size
  Bird()
    : super(
        position: Vector2(birdStartX, birdStartY),
        size: Vector2(birdWidth, birdHeight),
      );

  // pyshical world properties
  double velocity = 0;
  // final double gravity = 400;
  // final double jumpStrength = -300;

  /*

  LOAD

  */

  @override
  Future<void> onLoad() async {
    // load bird sprite image
    sprite = await Sprite.load('yellowbird-midflap.png');

    add(RectangleHitbox());
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
    velocity += gravity * dt;
    position.y += velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ground) {
      (parent as FlappyBird).gameover();
    }

    if(other is Pipe) {
      (parent as FlappyBird).gameover();
    }
  }
}
