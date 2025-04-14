
class WhackState {
  final List<bool> molePosition;
  final int score;
  final int lives;
  final int timeLeft;
  final bool isGameOver;
  final bool isPaused;

  WhackState({ required this.molePosition, required this.score, required this.lives, required this.timeLeft,
     this.isGameOver = false, this.isPaused = false});

  factory WhackState.initial() {
    return WhackState(
      molePosition: List.filled(16, false),
      score: 0,
      lives: 3,
      timeLeft: 60,
    );
  }

  WhackState copyWith({
    List<bool>? molePosition,
    int? score,
    int? lives,
    int? timeLeft,
    bool? isGameOver,
    bool? isPaused,
  }) {
    return WhackState(
      molePosition: molePosition ?? this.molePosition,
      score: score ?? this.score,
      lives: lives ?? this.lives,
      timeLeft: timeLeft ?? this.timeLeft,
      isGameOver: isGameOver ?? this.isGameOver,
      isPaused: isPaused ?? this.isPaused,
    );
  }

}