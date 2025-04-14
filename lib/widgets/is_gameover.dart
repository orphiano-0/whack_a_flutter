import 'package:flutter/material.dart';

class IsGameOver extends StatelessWidget {
  final int score;
  final VoidCallback onRestart;

  const IsGameOver({super.key, required this.score, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Text(
        'Game Over!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 71, 62, 51),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Game over! Your score is: $score', textAlign: TextAlign.center),
          SizedBox(height: 20),
          Icon(
            Icons.pest_control_rodent,
            size: 50,
            color: Color.fromARGB(255, 71, 62, 51),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            onRestart();
          },
          child: Text(
            'Restart',
            style: TextStyle(color: Color.fromARGB(255, 71, 62, 51),),
          ),
        ),
      ],
    );
  }
}
