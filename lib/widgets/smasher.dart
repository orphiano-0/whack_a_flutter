import 'package:flutter/material.dart';

class MoleSmasher extends StatefulWidget {
  const MoleSmasher({super.key});

  @override
  State<MoleSmasher> createState() => _MoleSmasherState();
}

class _MoleSmasherState extends State<MoleSmasher> {
  Offset mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.none,
          child: Listener(
            onPointerMove: (event) {
              setState(() {
                mousePosition = event.position;
              });
            },
            child: SizedBox.expand(),
          ),
        ),
        Positioned(
          left: mousePosition.dx - 25,
          top: mousePosition.dy - 25,
          child: Image.asset(
            'assets/images/pixelated_chicken.png',
            height: 50,
            width: 50,
          ),
        ),
      ],
    );
  }
}
