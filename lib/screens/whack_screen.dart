import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woof_route/bloc/whack_bloc.dart';
import 'package:woof_route/bloc/whack_event.dart';
import 'package:woof_route/bloc/whack_state.dart';
import 'package:woof_route/screens/components/whack_grid.dart';
import 'package:woof_route/screens/components/whack_timer.dart';
import 'package:woof_route/widgets/smasher.dart';
import 'package:woof_route/widgets/whack_buttons.dart';

import '../widgets/is_gameover.dart';

class WhackScreen extends StatelessWidget {
  const WhackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mole-rat', style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w700),),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade300,
      ),
      body: BlocBuilder<WhackBloc, WhackState>(
        builder: (context, state) {
          if (state.isGameOver) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IsGameOver(
                    onRestart:
                        () => context.read<WhackBloc>().add(WhackOnStart()),
                    score: state.score,
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '🔨: ${state.score}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '❤️: ${state.lives}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    // Text(
                    //   '⏰: ${state.timeLeft}',
                    //   style: const TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 20),
                WhackTimer(),
                const SizedBox(height: 20),
                // whack grid widget
                WhackGrid(),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WhackButtons(
                      onPressed:
                          () => context.read<WhackBloc>().add(WhackOnStart()),
                      content: 'Start',
                      color: Colors.blueGrey.shade300,
                    ),
                    WhackButtons(
                      onPressed:
                          () => context.read<WhackBloc>().add(
                            state.isPaused ? ResumeGame() : PauseGame(),
                          ),
                      content: state.isPaused ? 'Resume' : 'Pause',
                      color: state.isPaused ? Colors.blueGrey.shade900 : Colors.blueGrey.shade300,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
