import 'package:flutter/material.dart';

import '../Widgets/menu_drawer.dart';

class GlossaryPage extends StatefulWidget {
  const GlossaryPage({super.key});

  @override
  _GlossaryPageState createState() => _GlossaryPageState();
}

class _GlossaryPageState extends State<GlossaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glossary'),
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
