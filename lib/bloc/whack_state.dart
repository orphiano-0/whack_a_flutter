class WhackState {
  final List<bool> molePosition;
  final int score;
  final int lives;
  final int timeLeft;
  final bool isGameOver;
  final bool isPaused;
  final int speed;

  WhackState({
    required this.molePosition,
    required this.score,
    required this.lives,
    required this.timeLeft,
    required this.speed,
    this.isGameOver = false,
    this.isPaused = false,
  });

  factory WhackState.initial() {
    return WhackState(
      molePosition: List.filled(9, false),
      score: 0,
      lives: 11,
      timeLeft: 100,
      speed: 2000,
    );
  }

  WhackState copyWith({
    List<bool>? molePosition,
    int? score,
    int? lives,
    int? timeLeft,
    bool? isGameOver,
    bool? isPaused,

    int? speed,
  }) {
    return WhackState(
      molePosition: molePosition ?? this.molePosition,
      score: score ?? this.score,
      lives: lives ?? this.lives,
      timeLeft: timeLeft ?? this.timeLeft,
      isGameOver: isGameOver ?? this.isGameOver,
      isPaused: isPaused ?? this.isPaused,

      speed: speed ?? this.speed,
    );
  }
}
