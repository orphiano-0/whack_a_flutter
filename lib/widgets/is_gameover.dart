import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IsGameOver extends StatelessWidget {
  final int score;
  final VoidCallback onRestart;

  const IsGameOver({super.key, required this.score, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Text(
        'Game Over!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Pixel',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('The game is over! Your score is: $score', style: TextStyle(fontFamily: 'Pixel', fontSize: 10, color: Colors.white), textAlign: TextAlign.center),
          SizedBox(height: 20),
          Lottie.asset('assets/lottie/quacker.json', height: 130, width: 130),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            onRestart();
          },
          child: Text(
            'Restart',
            style: TextStyle(color: Colors.white, fontFamily: 'Pixel', fontSize: 10),
          ),
        ),
      ],
    );
  }
}
