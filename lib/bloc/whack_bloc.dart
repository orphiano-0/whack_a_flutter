import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'whack_event.dart';
import 'whack_state.dart';

class WhackBloc extends Bloc<WhackEvent, WhackState> {
  Timer? _timer;
  int? _speed;
  final Random _random = Random();
  final AudioPlayer _audioPlayer = AudioPlayer();

  WhackBloc() : super(WhackState.initial()) {
    on<WhackOnStart>((event, emit) {
      _timer?.cancel();
      emit(WhackState.initial());
      _startTimer();
    });

    // on<WhackOnRestart>((event, emit) {
    //   _timer?.cancel();
    //   emit(WhackState.initial());
    //   _startTimer();
    //   _showRandomMole(emit);
    // });

    on<Tick>((event, emit) async {
      if (state.isPaused || state.isGameOver) return;
      if (state.timeLeft <= 1) {
        _timer?.cancel();
        emit(state.copyWith(isGameOver: true));
      } else {
        emit(state.copyWith(timeLeft: state.timeLeft - 1));
        if (!state.isGameOver && !state.isPaused) {
          _showRandomMole(emit);
          _increaseSpeed(emit);
        }
      }
    });

    on<IncreaseSpeed>((event, emit) {
      if (state.isPaused || state.isGameOver) return;

      if (state.speed > 20) {
        emit(state.copyWith(speed: state.speed - 10)); // Decrease speed
      }
    });


    on<MoleWhacked>((event, emit) {
      if (state.isPaused || state.isGameOver) return;
      if (state.molePosition[event.moleIndex]) {
        final moleUpdates = List<bool>.filled(16, false);
        emit(state.copyWith(molePosition: moleUpdates, score: state.score + 1));

      } else {
        final newLives = state.lives - 1;
        emit(
          state.copyWith(
            lives: newLives,
            isGameOver: newLives <= 0 ? true : state.isGameOver,

          ),
        );
        _playClickSound();
      }
    });

    on<PauseGame>((event, emit) {
      emit(state.copyWith(isPaused: true));
    });

    on<ResumeGame>((event, emit) {
      emit(state.copyWith(isPaused: false));
    });

    on<EndGame>((event, emit) {
      _timer?.cancel();
      emit(state.copyWith(isGameOver: true));
    });
  }

  void _playClickSound() async {
    await _audioPlayer.play(AssetSource('assets/audio/smash.mp3'));
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: state.speed), (timer) {
      add(Tick());
    });
  }

  void _increaseSpeed(Emitter<WhackState> emit) {
    if (state.isPaused || state.isGameOver) return;

    if (state.score > 10 && state.score <= 30 && state.speed > 50) {
      add(IncreaseSpeed());
    } else if (state.score > 30 && state.score <= 50 && state.speed > 30) {
      add(IncreaseSpeed());
    } else if (state.score > 50 && state.speed > 20) {
      add(IncreaseSpeed());
    }
  }

  void _showRandomMole(Emitter<WhackState> emit) {
    final updateMoles = List<bool>.filled(16, false);
    final index = _random.nextInt(16);
    updateMoles[index] = true;
    emit(state.copyWith(molePosition: updateMoles));
  }
}
