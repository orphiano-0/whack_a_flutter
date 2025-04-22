import 'package:flutter/cupertino.dart';

abstract class WhackEvent {}

class WhackOnStart extends WhackEvent {}

class WhackOnRestart extends WhackEvent {}

class MoleAppeared extends WhackEvent {
  final int moleIndex;
  MoleAppeared(this.moleIndex);
}

class MoleWhacked extends WhackEvent {
  final int moleIndex;
  MoleWhacked(this.moleIndex);
}

class Tick extends WhackEvent {}

class EndGame extends WhackEvent {}

class PauseGame extends WhackEvent {}

class ResumeGame extends WhackEvent {}

class IncreaseSpeed extends WhackEvent {}

class SetInitialLives extends WhackEvent {
  final int lives;
  SetInitialLives(this.lives);
}

class SetInitialTimer extends WhackEvent {
  final int seconds;
  SetInitialTimer(this.seconds);
}

class SetBackground extends WhackEvent {
  final ImageProvider image;
  SetBackground(this.image);
}

