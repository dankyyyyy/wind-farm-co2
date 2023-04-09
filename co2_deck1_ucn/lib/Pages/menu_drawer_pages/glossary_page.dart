import 'package:flutter/material.dart';

import '../../Widgets/system/menu_drawer.dart';

class GlossaryPage extends StatefulWidget {
  const GlossaryPage({super.key});

  @override
  GlossaryPageState createState() => GlossaryPageState();
}

class GlossaryPageState extends State<GlossaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glossary'),
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
