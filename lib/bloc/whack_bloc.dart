import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'whack_event.dart';
import 'whack_state.dart';

class WhackBloc extends Bloc<WhackEvent, WhackState> {
  Timer? _gameTimer;
  Timer? _moleTimer;
  final Random _random = Random();

  final AudioPlayer _backgroundMusic = AudioPlayer();
  final AudioPlayer _quackSound = AudioPlayer();
  final AudioPlayer _smashSound = AudioPlayer();

  WhackBloc() : super(WhackState.initial()) {
    on<WhackOnStart>((event, emit) {
      _gameTimer?.cancel();
      _moleTimer?.cancel();
      emit(WhackState.initial());
      _startGameTimer();
      _startMoleTimer();
      _playBackgroundMusic();
    });

    // new bloc state
    on<SetInitialLives>((event, emit) {
      final newLives = event.lives.clamp(1, 8);
      emit(state.copyWith(
        lives: newLives,
        initialLives: newLives
      ));
    });

    on<SetInitialTimer>((event, emit) {
      emit(state.copyWith(
        timeLeft: event.seconds.toInt(),
        initialTimer: event.seconds,
      ));
    });

    on<SetBackground>((event, emit) {
      emit(state.copyWith(backgroundImage: event.image));
    });

    on<Tick>((event, emit) {
      if (state.isPaused || state.isGameOver) return;

      if (state.timeLeft < 1) {
        _gameTimer?.cancel();
        _moleTimer?.cancel();
        emit(state.copyWith(isGameOver: true));
        _stopBackgroundMusic();
      } else {
        emit(state.copyWith(timeLeft: state.timeLeft - 1));
      }
    });

    on<MoleWhacked>((event, emit) {
      if (state.isPaused || state.isGameOver) return;

      if (state.molePosition[event.moleIndex]) {
        final moleUpdates = List<bool>.filled(9, false);
        _onHitSmash();

        final newScore = state.score + 1;
        emit(state.copyWith(molePosition: moleUpdates, score: newScore));

        _checkAndIncreaseDifficulty(emit);
      } else {
        final newLives = state.lives - 1;
        emit(state.copyWith(
          lives: newLives,
          isGameOver: newLives <= 0 ? true : state.isGameOver,
        ));
        _playSmashSound();
      }
    });

    on<PauseGame>((event, emit) {
      emit(state.copyWith(isPaused: true));
      _backgroundMusic.pause();
    });

    on<ResumeGame>((event, emit) {
      emit(state.copyWith(isPaused: false));
      _backgroundMusic.resume();
    });

    on<EndGame>((event, emit) {
      _gameTimer?.cancel();
      _moleTimer?.cancel();
      emit(state.copyWith(isGameOver: true));
      _stopBackgroundMusic();
    });
  }

  void _startGameTimer() {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(Tick());
    });
  }

  void _startMoleTimer() {
    _moleTimer = Timer.periodic(Duration(milliseconds: state.speed), (timer) {
      if (!state.isPaused && !state.isGameOver) {
        _showRandomMole();
      }
    });
  }

  void _checkAndIncreaseDifficulty(Emitter<WhackState> emit) {
    int newSpeed = state.speed;

    if (state.score >= 50 && state.speed > 300) {
      newSpeed = 300;
    } else if (state.score >= 30 && state.speed > 500) {
      newSpeed = 500;
    } else if (state.score >= 15 && state.speed > 700) {
      newSpeed = 700;
    } else if (state.score >= 5 && state.speed > 1000) {
      newSpeed = 1000;
    }

    if (newSpeed != state.speed) {
      emit(state.copyWith(speed: newSpeed));
      _moleTimer?.cancel();
      _startMoleTimer();
    }
  }

  void _playBackgroundMusic() async {
    await _backgroundMusic.setReleaseMode(ReleaseMode.loop);
    await _backgroundMusic.play(AssetSource('audio/background_music.mp3'));
  }

  void _stopBackgroundMusic() async {
    await _backgroundMusic.stop();
  }

  void _onHitSmash() async {
    await _quackSound.stop();
    await _quackSound.play(AssetSource('audio/quack.mp3'));
  }

  void _playSmashSound() async {
    await _smashSound.stop();
    await _smashSound.play(AssetSource('audio/smash.mp3'));
  }

  void _showRandomMole() {
    final updateMoles = List<bool>.filled(9, false);
    final index = _random.nextInt(9);
    updateMoles[index] = true;
    emit(state.copyWith(molePosition: updateMoles));
  }

  void setVolume(double volume) {
    _backgroundMusic.setVolume(volume);
    _quackSound.setVolume(volume);
    _smashSound.setVolume(volume);
  }
}
