import 'package:flutter/material.dart';

class BurgerMenu extends StatelessWidget {
  const BurgerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            height: 120,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/deck1_logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                )),
            onTap: () {
              // TBA
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Glossary',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                )),
            onTap: () {
              // TBA
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Settings',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                )),
            onTap: () {
              // TBA
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('About',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                )),
            onTap: () {
              // TBA
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
