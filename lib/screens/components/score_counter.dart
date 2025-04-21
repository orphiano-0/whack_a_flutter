import 'package:flutter/material.dart';

class WhackCounter extends StatefulWidget {
  final int score;
  final String label;
  final IconData icon;

  const WhackCounter({super.key, required this.score, required this.icon, required this.label });

  @override
  State<WhackCounter> createState() => _WhackCounterState();
}

class _WhackCounterState extends State<WhackCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int _previousScore = 0;

  @override
  void initState() {
    super.initState();
    _previousScore = widget.score;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.01,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void didUpdateWidget(covariant WhackCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.score != oldWidget.score) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // decoration: BoxDecoration(
        //   color: Colors.blueGrey.shade900,
        //   borderRadius: BorderRadius.circular(12),
        // ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, color: Colors.black,),
            const SizedBox(width: 8),
            Text(
              '${widget.label}: ${widget.score}',
              style: const TextStyle(
                fontFamily: 'Pixel',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
