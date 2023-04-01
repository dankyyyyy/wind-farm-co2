import 'package:flutter/material.dart';

import '../Widgets/menu_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final bool _darkmode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: Colors.black,
          leading: Builder(
            builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
        ),
        drawer: const MenuDrawer(),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text(
                'Dark Mode',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                ),
              ),
              trailing: Switch(
                  value: _darkmode,
                  onChanged: (value) {
                    setState(() {
                      value = true;
                    });
                  }),
            ),
          ],
        ));
  }
}
