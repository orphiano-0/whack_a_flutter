import 'package:flutter/cupertino.dart';

class WhackState {
  final List<bool> molePosition;
  final int score;
  final int lives;
  final int speed;
  final int timeLeft;
  final bool isGameOver;
  final bool isPaused;

  final ImageProvider backgroundImage;
  final int initialLives;
  final int initialTimer;

  WhackState({
    required this.molePosition,
    required this.score,
    required this.lives,
    required this.speed,
    required this.timeLeft,
    this.isGameOver = false,
    this.isPaused = false,

    required this.backgroundImage,
    required this.initialLives,
    required this.initialTimer
  });

  factory WhackState.initial() {
    return WhackState(
      molePosition: List.filled(9, false),
      score: 0,
      lives: 8,
      timeLeft: 100,
      speed: 1500,
      initialLives: 8,
      initialTimer: 100,
      backgroundImage: AssetImage('assets/images/mole_background.png')
    );
  }

  WhackState copyWith({
    List<bool>? molePosition,
    int? score,
    int? lives,
    int? timeLeft,
    int? initialLives,
    int? initialTimer,
    ImageProvider? backgroundImage,
    bool? isGameOver,
    bool? isPaused,

    int? speed,
  }) {
    return WhackState(
      molePosition: molePosition ?? this.molePosition,
      score: score ?? this.score,
      lives: lives ?? this.lives,
      timeLeft: timeLeft ?? this.timeLeft,
      speed: speed ?? this.speed,

      backgroundImage: backgroundImage ?? this.backgroundImage,
      initialLives: initialLives ?? this.initialLives,
      initialTimer: initialTimer ?? this.initialTimer,

      isGameOver: isGameOver ?? this.isGameOver,
      isPaused: isPaused ?? this.isPaused,

    );
  }
}
