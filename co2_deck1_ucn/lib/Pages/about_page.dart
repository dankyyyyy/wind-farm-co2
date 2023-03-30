import 'package:co2_deck1_ucn/Widgets/menu_drawer.dart';
import 'package:flutter/material.dart';

import '../Resources/images.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer()),
        ),
      ),
      drawer: const MenuDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 30, 5),
            child: Column(
              children: const [
                Image(
                  image: AssetImage(Images.logo_notext),
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(height: 30),
                Text(
                  "DECK1 is a software development company working in the offshore renewable energy industry.\n",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontFamily: 'Leto', fontSize: 16),
                ),
                Text(
                  "We specialise in software solutions that center around big data, AI, IoT and automation. We are on a mission to make offshore logistic operations more transparent, sustainable, safer and more efficient.\n",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontFamily: 'Leto', fontSize: 16),
                ),
                Text(
                  "We do that by collecting and analysing great amounts of real time operations data and adding AI and predictive analysis to recommend, automate and provide new knowledge to both vessel operators, and wind turbine manufacturers.\n",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontFamily: 'Leto', fontSize: 16),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 5, 30, 5),
            child: Text("© 2023 DECK1. All Rights Reserved.",
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
