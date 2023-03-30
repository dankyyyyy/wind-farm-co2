import 'package:flutter/material.dart';
import '../Pages/about_page.dart';
import '../Pages/comparison_page.dart';
import '../Pages/glossary_page.dart';
import '../Pages/home_page.dart';
import '../Pages/settings_page.dart';
import '../Resources/images.dart';
import '../Resources/menu_icons.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40, bottom: 30),
            height: 130,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.logo),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage(MenuIcons.home),
              backgroundColor: Colors.transparent,
              radius: 13,
            ),
            title: const Text('Home',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                )),
            onTap: () {
              // TBA
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage(MenuIcons.glossary),
                backgroundColor: Colors.transparent,
                radius: 14),
            title: const Text('Glossary',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                )),
            onTap: () {
              // TBA
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GlossaryPage()));
            },
          ),
          ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage(MenuIcons.compare),
                backgroundColor: Colors.transparent,
                radius: 14),
            title: const Text('Compare Plants',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                )),
            onTap: () {
              // TBA
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ComparisonPage()));
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage(MenuIcons.settings),
              backgroundColor: Colors.transparent,
              radius: 13,
            ),
            title: const Text('Settings',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                )),
            onTap: () {
              // TBA
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage(MenuIcons.about),
              backgroundColor: Colors.transparent,
              radius: 13,
            ),
            title: const Text('About',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                )),
            onTap: () {
              // TBA
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
        ],
      ),
    );
  }
}
