import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woof_route/bloc/whack_bloc.dart';
import 'package:woof_route/bloc/whack_event.dart';
import 'package:woof_route/bloc/whack_state.dart';
import 'package:woof_route/widgets/whack_buttons.dart';

import '../widgets/is_gameover.dart';

class WhackScreen extends StatelessWidget {
  const WhackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whack-a-Mole'),
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
                    onRestart: () => context.read<WhackBloc>().add(WhackOnStart()),
                    score: state.score,
                  )
                ],
                // children: [
                //   Text(
                //     'Game Over!',
                //     style: TextStyle(
                //       fontSize: 24,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.red,
                //     ),
                //   ),
                //   const SizedBox(height: 20),
                //   Text(
                //     'Score: ${state.score}',
                //     style: const TextStyle(fontSize: 18),
                //   ),
                //   const SizedBox(height: 20),
                //   ElevatedButton(
                //     onPressed:
                //         () => context.read<WhackBloc>().add(WhackOnStart()),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.blueGrey.shade300,
                //     ),
                //     child: const Text('Restart'),
                //   ),
                // ],
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '❤️: ${state.lives}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '⏰: ${state.timeLeft}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1,
                            ),
                        itemCount: 16,
                        itemBuilder: (context, moleIndex) {
                          final isMoleUp = state.molePosition[moleIndex];
                          return GestureDetector(
                            onTap:
                                () => context.read<WhackBloc>().add(
                                  MoleWhacked(moleIndex),
                                ),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    isMoleUp
                                        ? Colors.red
                                        : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child:
                                    isMoleUp
                                        ? Image.asset(
                                          'assets/images/rodent.png',
                                          width: 80,
                                          height: 80,
                                        )
                                        : Icon(
                                          Icons.circle,
                                          color: Colors.grey,
                                        ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WhackButtons(onPressed: () => context.read<WhackBloc>().add(WhackOnStart()), content: 'Start Game', color: Colors.blueGrey),
                    // ElevatedButton(
                    //   onPressed:
                    //       () => context.read<WhackBloc>().add(WhackOnStart()),
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.teal,
                    //   ),
                    //   child: const Text('Start Game'),
                    // ),
                    // FloatingActionButton(
                    //   onPressed:
                    //       () => context.read<WhackBloc>().add(
                    //         state.isPaused ? ResumeGame() : PauseGame(),
                    //       ),
                    //   backgroundColor: Colors.teal,
                    //   child: Icon(
                    //     state.isPaused ? Icons.play_arrow : Icons.pause,
                    //   ),
                    // ),
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
