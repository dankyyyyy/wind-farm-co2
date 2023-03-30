import 'package:co2_deck1_ucn/Widgets/menu_drawer.dart';
import 'package:flutter/material.dart';

class ComparisonPage extends StatefulWidget {
  const ComparisonPage({super.key});

  @override
  _ComparisonPageState createState() => _ComparisonPageState();
}

class _ComparisonPageState extends State<ComparisonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Plants'),
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer()),
        ),
      ),
      drawer: const MenuDrawer(),
    );
  }
}
