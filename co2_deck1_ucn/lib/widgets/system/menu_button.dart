import 'package:co2_deck1_ucn/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;
  final bool mini;

  const MenuButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.white,
    this.mini = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: themeProvider.getTheme().brightness == Brightness.dark
          ? const Color.fromARGB(255, 56, 74, 98)
          : Colors.white,
      foregroundColor: themeProvider.getTheme().brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
      mini: mini,
      child: const Icon(Icons.menu),
    );
  }
}
