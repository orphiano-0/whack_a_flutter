import 'package:flutter/material.dart';

class WhackButtons extends StatelessWidget {
  final VoidCallback? onPressed;
  final String content;
  final Color color;

  const WhackButtons({
    super.key,
    required this.onPressed,
    required this.content,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: color,
          elevation: 2,
        ),
        child: Text(
          content,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Pixel',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
