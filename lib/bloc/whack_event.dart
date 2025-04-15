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
