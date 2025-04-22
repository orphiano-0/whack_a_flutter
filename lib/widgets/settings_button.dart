import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color color;

  const SettingsButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: color,
          elevation: 2,
        ),
        child: Icon(icon, color: Colors.white, size: 40,)
        ),
    );
  }
}
