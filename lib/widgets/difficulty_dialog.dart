import 'package:flutter/material.dart';

class DifficultyDialog extends StatefulWidget {
  final int speed;

  const DifficultyDialog({ super.key, required this.speed, });

  @override
  State<DifficultyDialog> createState() => _DifficultyDialogState();
}

class _DifficultyDialogState extends State<DifficultyDialog> {
  double _opacity = 0.0;
  int _speed = 0;

  void _triggerTextFade() {
    setState(() {
      _opacity = 1.0;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _opacity = 0.0;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(opacity: _opacity, duration: Duration(milliseconds: 500),
            child: Text(
              'Increased Speed: ${widget.speed}',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Pixel',
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
