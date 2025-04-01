# 🎮 Flappy Bird Game with Flutter & Flame: A Learning Journey 🚀

![Flappy Bird Game Demo](https://img.youtube.com/vi/qADIcXTDFGs/0.jpg)  
*Video Tutorial: [Build a Flappy Bird Game with Flutter & Flame](https://www.youtube.com/watch?v=qADIcXTDFGs)*

## 📚 Table of Contents
- [🎮 Flappy Bird Game with Flutter \& Flame: A Learning Journey 🚀](#-flappy-bird-game-with-flutter--flame-a-learning-journey-)
  - [📚 Table of Contents](#-table-of-contents)
  - [🌟 Introduction](#-introduction)
  - [🛠️ Project Setup](#️-project-setup)
    - [Step 1: Dependencies](#step-1-dependencies)
    - [Step 2: Asset Setup](#step-2-asset-setup)
    - [Step 3: Game Initialization](#step-3-game-initialization)
  - [🕹️ Core Game Components](#️-core-game-components)
    - [🐦 Bird Implementation](#-bird-implementation)
    - [🌄 Background \& Ground](#-background--ground)
    - [🚪 Pipes System](#-pipes-system)
  - [🎮 Game Mechanics](#-game-mechanics)
    - [💥 Collision Detection](#-collision-detection)
    - [📊 Scoring System](#-scoring-system)
    - [🎯 Game Over \& Restart](#-game-over--restart)
  - [⚙️ Constants \& Configuration](#️-constants--configuration)
  - [🧠 Key Concepts Learned](#-key-concepts-learned)
  - [📖 References](#-references)
  - [🚀 Next Steps For Updates](#-next-steps-for-updates)

---

## 🌟 Introduction
This documentation outlines the implementation of a **Flappy Bird** clone using **Flutter** and the **Flame game engine**. Flame simplifies game development by providing essential tools for rendering, collision detection, and game loop management. Below, we break down the project into digestible components with code examples and explanations.

---

## 🛠️ Project Setup

### Step 1: Dependencies
Add Flame to your `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  flame: ^1.10.0
```

### Step 2: Asset Setup
1. Create an `assets/images` folder.
2. Add sprites (bird, background, pipes, ground) to `assets/images`.
3. Declare assets in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
```

### Step 3: Game Initialization
```dart
// main.dart
void main() {
  runApp(
    MaterialApp(
      home: GameWidget(game: FlappyBirdGame()),
  );
}

// game.dart
class FlappyBirdGame extends FlameGame with TapDetector, CollisionCallbacks {
  // Game components initialized here
}
```

**[⬆ Back to Top](#-table-of-contents)**

---

## 🕹️ Core Game Components

### 🐦 Bird Implementation
**Key Features**:
- Gravity and jump mechanics
- Sprite animation
- Collision detection

```dart
// components/bird.dart
class Bird extends SpriteComponent with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  double velocity = 0;
  final double gravity = 800;
  final double jumpStrength = -300;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('bird.png');
    position = Vector2(100, gameRef.size.y / 2);
    add(CircleHitbox());
  }

  void flap() => velocity = jumpStrength;

  @override
  void update(double dt) {
    velocity += gravity * dt;
    position.y += velocity * dt;
    super.update(dt);
  }
}
```

**[⬆ Back to Top](#-table-of-contents)**

---

### 🌄 Background & Ground
**Infinite Scrolling Ground**:
```dart
// components/ground.dart
class Ground extends SpriteComponent {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('ground.png');
    position = Vector2(0, gameRef.size.y - height);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= groundScrollSpeed * dt;
    if (position.x < -size.x) position.x = 0;
  }
}
```

**[⬆ Back to Top](#-table-of-contents)**

---

### 🚪 Pipes System
**Randomized Pipe Generation**:
```dart
// components/pipe.dart
class Pipe extends SpriteComponent {
  final bool isTop;

  Pipe({required this.isTop});

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(isTop ? 'pipe_top.png' : 'pipe_bottom.png');
    add(RectangleHitbox());
  }
}

// components/pipe_manager.dart
class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  final Timer pipeSpawnTimer = Timer(2);

  @override
  void update(double dt) {
    pipeSpawnTimer.update(dt);
    if (pipeSpawnTimer.current >= pipeInterval) {
      _spawnPipes();
      pipeSpawnTimer.reset();
    }
  }
}
```

**[⬆ Back to Top](#-table-of-contents)**

---

## 🎮 Game Mechanics

### 💥 Collision Detection
```dart
// In Bird class
@override
void onCollision(Set<Vector2> points, PositionComponent other) {
  if (other is Ground || other is Pipe) {
    gameRef.gameOver();
  }
  super.onCollision(points, other);
}
```

### 📊 Scoring System
```dart
// components/score.dart
class ScoreDisplay extends TextComponent {
  @override
  Future<void> onLoad() async {
    textRenderer = TextPaint(
      style: const TextStyle(fontSize: 48, color: Colors.black),
    );
    position = Vector2(gameRef.size.x / 2, 50);
  }

  @override
  void update(double dt) {
    text = gameRef.score.toString();
  }
}
```

### 🎯 Game Over & Restart
```dart
// In FlappyBirdGame class
void gameOver() {
  isGameOver = true;
  pauseEngine();
  showDialog(context: context, builder: (_) => AlertDialog(
    title: Text('Game Over! Score: $score'),
    actions: [TextButton(onPressed: resetGame, child: Text('Restart'))],
  ));
}

void resetGame() {
  score = 0;
  isGameOver = false;
  resumeEngine();
}
```

**[⬆ Back to Top](#-table-of-contents)**

---

## ⚙️ Constants & Configuration
Centralize game parameters in `constants.dart`:
```dart
const double birdWidth = 60;
const double birdHeight = 40;
const double pipeGap = 200;
const double groundScrollSpeed = 200;
// Add more constants as needed
```

**[⬆ Back to Top](#-table-of-contents)**

---

## 🧠 Key Concepts Learned
1. **Flame Architecture**:
   - `FlameGame` as the core game controller
   - `Component`-based system for reusable elements
2. **Physics Simulation**:
   - Gravity and velocity calculations
   - Infinite scrolling mechanics
3. **Collision Handling**:
   - `Hitbox` shapes (Circle, Rectangle)
   - Collision callback methods
4. **State Management**:
   - Game pause/resume logic
   - Score tracking and reset

---

## 📖 References
- **Flame Documentation**: [flame-engine.org](https://flame-engine.org)
- **Dart Language Guide**: [dart.dev](https://dart.dev)
- **Flutter Widgets Catalog**: [flutter.dev/widgets](https://flutter.dev/widgets)
- **Original Tutorial**: [YouTube Video](https://www.youtube.com/watch?v=qADIcXTDFGs)

**[⬆ Back to Top](#-table-of-contents)**

---

## 🚀 Next Steps For Updates
1. Add sound effects for jumps and collisions
2. Implement a high-score system using `SharedPreferences`
3. Create a menu screen with difficulty options
4. Expand the game with power-ups or new obstacles

```dart
// Example: Adding a sound effect
final AudioPlayer audioPlayer = AudioPlayer();
void flap() {
  velocity = jumpStrength;
  audioPlayer.play(AssetSource('sounds/jump.wav'));
}
```

**[⬆ Back to Top](#-table-of-contents)**

