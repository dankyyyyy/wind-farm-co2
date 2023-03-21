import 'package:co2_deck1_ucn/Pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Program());

class Program extends StatelessWidget {
  const Program({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: homePage(),
    );
  }
}
