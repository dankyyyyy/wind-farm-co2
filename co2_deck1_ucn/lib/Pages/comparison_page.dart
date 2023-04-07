import 'package:co2_deck1_ucn/Widgets/system/menu_drawer.dart';
import 'package:flutter/material.dart';

class ComparisonPage extends StatefulWidget {
  const ComparisonPage({super.key});

  @override
  ComparisonPageState createState() => ComparisonPageState();
}

class ComparisonPageState extends State<ComparisonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Plants'),
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
