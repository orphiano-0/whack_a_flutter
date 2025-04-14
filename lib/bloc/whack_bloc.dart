import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'whack_event.dart';
import 'whack_state.dart';

class WhackBloc extends Bloc<WhackEvent, WhackState> {
  Timer? _timer;
  final Random _random = Random();

  WhackBloc() : super(WhackState.initial()) {
    on<WhackOnStart>((event, emit) {
      _timer?.cancel();
      emit(WhackState.initial());
      _startTimer();
      _showRandomMole(emit);
    });

    on<Tick>((event, emit) {
      if (state.isPaused || state.isGameOver) return;
      if (state.timeLeft <= 1) {
        _timer?.cancel();
        emit(state.copyWith(isGameOver: true));
      } else {
        emit(state.copyWith(timeLeft: state.timeLeft - 1));
        _showRandomMole(emit);
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

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      add(Tick());
    });
  }

  void _showRandomMole(Emitter<WhackState> emit) {
    final updateMoles = List<bool>.filled(16, false);
    final index = _random.nextInt(16);
    updateMoles[index] = true;
    emit(state.copyWith(molePosition: updateMoles));
  }
}
