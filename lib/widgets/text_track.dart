import 'package:flutter/material.dart';

class TextTrack extends StatelessWidget {
  final String value;

  const TextTrack({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 71, 62, 51),
      ),
      textAlign: TextAlign.center,
    );
  }
}
