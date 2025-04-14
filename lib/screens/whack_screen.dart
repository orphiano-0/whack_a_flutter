import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woof_route/bloc/whack_bloc.dart';
import 'package:woof_route/bloc/whack_event.dart';
import 'package:woof_route/bloc/whack_state.dart';

class WhackScreen extends StatelessWidget {
  const WhackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: Text('Whack-a-Mole',),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<WhackBloc, WhackState>(
        builder: (context, state) {
          if (state.isGameOver) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Game Over!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Score: ${state.score}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.read<WhackBloc>().add(WhackOnStart()),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    child: const Text('Restart'),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Score: ${state.score}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Lives: ${state.lives}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Time Left: ${state.timeLeft}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemCount: 9,
                        itemBuilder: (context, moleIndex) {
                          final isMoleUp = state.molePosition[moleIndex];
                          return GestureDetector(
                            onTap: () =>
                                context.read<WhackBloc>().add(MoleWhacked(moleIndex)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isMoleUp ? Colors.brown : Colors.grey.shade300,
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
                                child: Icon(
                                  isMoleUp ? Icons.pest_control_rodent : Icons.circle,
                                  size: 40,
                                  color: isMoleUp ? Colors.white : Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.read<WhackBloc>().add(WhackOnStart()),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                      child: const Text('Start Game'),
                    ),
                    FloatingActionButton(
                      onPressed: () => context.read<WhackBloc>().add(
                        state.isPaused ? ResumeGame() : PauseGame(),
                      ),
                      backgroundColor: Colors.teal,
                      child: Icon(state.isPaused ? Icons.play_arrow : Icons.pause),
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
