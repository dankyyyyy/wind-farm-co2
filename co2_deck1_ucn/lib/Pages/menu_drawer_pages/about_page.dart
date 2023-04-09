import 'package:co2_deck1_ucn/Widgets/system/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Resources/images.dart';
import '../../providers/theme_provider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text('About'),
          leading: Builder(
            builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
        ),
        drawer: const MenuDrawer(),
        body: Column(children: [
          
          Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 30, 5),
              child: Column(children: [
                Image(
                  image: themeProvider.getTheme().brightness == Brightness.dark
                      ? const AssetImage(Images.darkLogoNotext)
                      : const AssetImage(Images.logoNotext),
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(height: 30),
                Text(
                  "DECK1 is a software development company working in the offshore renewable energy industry.\n",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "We specialise in software solutions that center around big data, AI, IoT and automation. We are on a mission to make offshore logistic operations more transparent, sustainable, safer and more efficient.\n",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "We do that by collecting and analysing great amounts of real time operations data and adding AI and predictive analysis to recommend, automate and provide new knowledge to both vessel operators, and wind turbine manufacturers.\n",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ])),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 30, 5),
            child: Text("© 2023 DECK1. All Rights Reserved.",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center),
          )
        ]));
  }
}
