import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woof_route/bloc/whack_bloc.dart';
import 'package:woof_route/bloc/whack_event.dart';
import 'package:woof_route/bloc/whack_state.dart';
import 'package:woof_route/screens/components/lives_counter.dart';
import 'package:woof_route/screens/components/score_counter.dart';
import 'package:woof_route/screens/components/whack_grid.dart';
import 'package:woof_route/widgets/whack_buttons.dart';

import '../widgets/is_gameover.dart';

class WhackScreen extends StatelessWidget {
  const WhackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WhackBloc, WhackState>(
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
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Smash Quacker',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Pixel',
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                onPressed:
                    () => context.read<WhackBloc>().add(
                      state.isPaused ? ResumeGame() : PauseGame(),
                    ),
                icon:
                    state.isPaused
                        ? Icon(Icons.play_arrow, color: Colors.white, size: 30)
                        : Icon(Icons.pause, color: Colors.white, size: 30),
              ),
            ],
            centerTitle: true,
            backgroundColor: Colors.blueGrey.shade900,
          ),

          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/mole_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      WhackCounter(score: state.score, icon: Icons.star, label: 'Score',),
                      SizedBox(width: 40),
                      WhackCounter(score: state.timeLeft, icon: Icons.timer, label: 'Timer'),
                    ],
                  ),
                  // Text(
                  //   'Timer: ${state.timeLeft}',
                  //   style: const TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(height: 50),
                  LivesCounter(lives: state.lives),
                  const SizedBox(height: 20),
                  // WhackTimer(),
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
                        color: Colors.blueGrey.shade900,
                      ),
                      // WhackButtons(
                      //   onPressed:
                      //       () => context.read<WhackBloc>().add(
                      //         state.isPaused ? ResumeGame() : PauseGame(),
                      //       ),
                      //   content: state.isPaused ? 'Resume' : 'Pause',
                      //   color:
                      //       state.isPaused
                      //           ? Colors.blueGrey.shade900
                      //           : Colors.blueGrey.shade300,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
