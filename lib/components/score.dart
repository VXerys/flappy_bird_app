import 'package:flame/components.dart';
import 'package:flappy_bird_app/game.dart';
import 'package:flutter/material.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyBird> {
  ScoreText()
    : super(
        text: '0',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 50,
            color: Color.fromARGB(255, 73, 73, 73),
          ),
        ),
      );

  @override
  Future<void> onLoad() async {
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - size.y - 50);
  }

  @override
  void update(double dt) {
    final newText = gameRef.score.toString();
    if (text != newText) {
      text = newText;
    }
  }
}
