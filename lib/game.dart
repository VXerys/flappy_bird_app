import 'dart:async';

import 'package:flame/game.dart';
import 'package:flappy_bird_app/components/bird.dart';

class FlappyBird extends FlameGame {
  /*

  Basic Game Components:
  - bird 
  - background
  - pipes
  - score

  */

  late Bird bird;

  /* 

  LOAD

  */

  @override
  FutureOr<void> onLoad() {
    bird = Bird();
    add(bird);
  }
}
