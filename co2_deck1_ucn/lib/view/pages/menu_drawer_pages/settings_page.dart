import 'package:co2_deck1_ucn/controller/providers/theme_provider.dart';
import 'package:co2_deck1_ucn/controller/utils/size_config.dart';
import 'package:co2_deck1_ucn/view/widgets/system/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
            title: const Text('Settings'),
            leading: Builder(
              builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer()),
            )),
        drawer: const MenuDrawer(),
        body: ListView(padding: EdgeInsets.zero, children: [
          ListTile(
            title: Text(
              'Dark Mode',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Switch(
                value: themeProvider.getTheme().brightness == Brightness.dark,
                onChanged: (value) {
                  value
                      ? themeProvider.setDarkTheme()
                      : themeProvider.setLightTheme();
                }),
          )
        ]));
  }
}
