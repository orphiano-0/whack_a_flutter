import 'package:flutter/material.dart';

class WhackTimer extends StatefulWidget {
  const WhackTimer({super.key});

  @override
  State<WhackTimer> createState() => _WhackTimerState();
}

class _WhackTimerState extends State<WhackTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final int timerDuration = 30;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: timerDuration),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _animation.value,
                minHeight: 12.0, // Thicker bar
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey.shade900),
              );
            },
          ),
        ],
      ),
    );
  }
}
