import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woof_route/bloc/whack_bloc.dart';
import 'package:woof_route/bloc/whack_event.dart';
import 'package:woof_route/bloc/whack_state.dart';
import 'package:woof_route/screens/components/lives_counter.dart';
import 'package:woof_route/screens/components/whack_counter.dart';
import 'package:woof_route/screens/components/whack_grid.dart';

import '../widgets/is_gameover.dart';

class WhackScreen extends StatelessWidget {
  const WhackScreen({super.key});

  void _showGameOverDialog(BuildContext context, WhackState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return IsGameOver(
          score: state.score,
          onRestart: () {
            Navigator.of(dialogContext).pop();
            context.read<WhackBloc>().add(WhackOnStart());
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WhackBloc, WhackState>(
      builder: (context, state) {
        if (state.isGameOver) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showGameOverDialog(context, state);
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Quack-a-Duck',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Pixel',
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                () => context.read<WhackBloc>().add(EndGame());
              },
              icon: Icon(
                Icons.arrow_circle_left,
                size: 30,
                color: Colors.white,
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
                image: state.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      WhackCounter(
                        count: state.score,
                        icon: Icons.star,
                        label: 'Score',
                      ),
                      SizedBox(width: 40),
                      WhackCounter(
                        count: state.timeLeft,
                        icon: Icons.timer,
                        label: 'Timer',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LivesCounter(lives: state.lives),
                  const SizedBox(height: 150),
                  WhackGrid(),
                  const SizedBox(height: 40),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     WhackButtons(
                  //       onPressed:
                  //           () => context.read<WhackBloc>().add(WhackOnStart()),
                  //       content: 'Start',
                  //       color: Colors.blueGrey.shade900,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
