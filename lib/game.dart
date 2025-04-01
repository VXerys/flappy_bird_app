import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird_app/components/background.dart';
import 'package:flappy_bird_app/components/bird.dart';
import 'package:flappy_bird_app/components/ground.dart';
import 'package:flappy_bird_app/components/pipe.dart';
import 'package:flappy_bird_app/components/pipeManager.dart';
import 'package:flappy_bird_app/components/score.dart';
import 'package:flappy_bird_app/constants.dart' show birdStartX, birdStartY;
import 'package:flutter/material.dart';

class FlappyBird extends FlameGame with TapDetector, HasCollisionDetection {
  /*

  Basic Game Components:
  - bird 
  - background
  - pipes
  - score

  */

  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  /* 

  LOAD

  */

  @override
  FutureOr<void> onLoad() {
    background = Background(size);
    add(background);

    ground = Ground();
    add(ground);

    bird = Bird();
    add(bird);

    pipeManager = PipeManager();
    add(pipeManager);

    scoreText = ScoreText();
    add(scoreText);
  }

  /* 

  OnTap

  */

  @override
  void onTap() {
    bird.flap();
  }

  int score = 0;

  void incrementScore() {
    score += 1;
  }

  bool isGameOver = false;

  void gameover() {
    if (isGameOver) {
      return;
    }
    isGameOver = true;
    pauseEngine();

    showDialog(
      context: buildContext!,
      builder:
          (context) => AlertDialog(
            title: const Text('Game Over'),
            content: Text('Score: $score'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  resetGame();
                },
                child: const Text("Restart"),
              ),
            ],
          ),
    );
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;
    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());
    resumeEngine();
  }
}
