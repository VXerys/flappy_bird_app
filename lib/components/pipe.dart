import 'dart:async' show FutureOr;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart'
    show HasGameRef, Sprite, SpriteComponent, Vector2;
import 'package:flappy_bird_app/constants.dart' show groundScrollingSpeed;
import 'package:flappy_bird_app/game.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBird> {
  final bool isTopPipe;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
    : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(
      isTopPipe ? 'pipe-green.png' : 'pipe-green-top.png',
    );
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= groundScrollingSpeed * dt;

    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
