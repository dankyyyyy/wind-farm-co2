import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:co2_deck1_ucn/view/widgets/system/menu_drawer.dart';
import 'package:co2_deck1_ucn/controller/utils/size_config.dart';
import 'package:co2_deck1_ucn/controller/providers/theme_provider.dart';
import 'package:co2_deck1_ucn/controller/utils/glossary_utils.dart';
import '../glossary_details.dart';

class GlossaryPage extends StatefulWidget {
  const GlossaryPage({super.key});

  @override
  GlossaryPageState createState() => GlossaryPageState();
}

class GlossaryPageState extends State<GlossaryPage> {
  final glossaryUtils = GlossaryUtils();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

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
        body: Column(
          children: [
            const SizedBox(height: 15),
            for (String title in titles)
              GestureDetector(
                  child: SizedBox(
                    height: 120,
                    child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
                            child: Row(children: [
                              CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              themeProvider
                                                          .getTheme()
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? glossaryUtils
                                                      .determineIconDark(title)
                                                  : glossaryUtils
                                                      .determineIconLight(
                                                          title),
                                            ),
                                          )))),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(title,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall)))
                            ]))),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GlossaryDetails(title)));
                  }),
            SizedBox(
              child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.all(12),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
                      child: Row(children: [
                        const Icon(
                          Icons.info_outline,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: Text("Fun Fact",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall)),
                              const SizedBox(height: 5),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  funfacts[generateRandomFunFact()],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              )
                            ],
                          ),
                        )
                      ]))),
            ),
          ],
        ));
  }

  static List<String> titles = <String>[
    "Green Energy vs\n Traditional Sources",
    "Onshore vs Offshore\n Windfarms",
    "A Rundown on CO2 Taxes",
    "Helicopters vs Vessels",
  ];

  int generateRandomFunFact() {
    Random random = Random();
    int randomFunFact = random.nextInt(funfacts.length);
    return randomFunFact;
  }

  static List<String> funfacts = <String>[
    "Windmills have been in use since 2000BCE, first developed in Persia and China.",
    "The first wind turbine was built in Scotland in 1887 by Professor James Blyth.",
    "The world's largest offshore wind farm is Hornsea 1, off the coast of England, with a capacity of 1.2 GW.",
    "The world's largest onshore wind farm is the Gansu wind farm in China, with a capacity of over 7 GW.",
    "The average wind turbine generates enough electricity to power around 1,500 homes per year.",
    "A single rotation of a large wind turbine blade can generate enough electricity to power a home for 29 hours.",
    "The country with the highest percentage of electricity generated from wind energy is Denmark, with around 50% of its electricity coming from wind power as of 2020.",
    "The average lifespan of a wind turbine is around 20-25 years.",
    "The largest wind turbine manufacturer in the world is Denmark's Vestas, followed by China's Goldwind and General Electric (GE) from the US.",
    "The tallest wind turbine in the world is located in Germany and stands at a height of 246.5 meters.",
    "Wind energy is the only form of alternative energy that doesn’t require water.",
  ];
}
