import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird_app/constants.dart'
    show groundHeight, groundScrollingSpeed;
import '../game.dart';

class Ground extends SpriteComponent with HasGameRef<FlappyBird>, CollisionCallbacks {
  Ground() : super();

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('base.png');
    size = Vector2(2 * gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);

    sprite = await Sprite.load('base.png');

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= groundScrollingSpeed * dt;
    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
