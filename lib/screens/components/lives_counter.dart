import 'package:flutter/material.dart';

class LivesCounter extends StatelessWidget {
  final int lives;

  const LivesCounter({super.key, required this.lives});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      runSpacing: 8.0,
      children: List.generate(
        lives,
        (index) => Image.asset('assets/images/rodent.png', height: 25, width: 25),
      ),
    );
  }
}
