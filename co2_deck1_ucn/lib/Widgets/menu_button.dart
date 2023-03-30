import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;
  final bool mini;

  const MenuButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black,
    this.mini = true,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      mini: mini,
      child: const Icon(Icons.menu),
    );
  }
}
