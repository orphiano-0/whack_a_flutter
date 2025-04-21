import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LivesCounter extends StatelessWidget {
  final int lives;

  const LivesCounter({super.key, required this.lives});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Wrap(
        spacing: 4.0,
        runSpacing: 8.0,
        children: List.generate(
          lives,
          (index) => SizedBox(
            height: 30,
            width: 30,
            child: Lottie.asset('assets/lottie/lives.json', fit: BoxFit.cover),
          )
        ),
      ),
    );
  }
}
