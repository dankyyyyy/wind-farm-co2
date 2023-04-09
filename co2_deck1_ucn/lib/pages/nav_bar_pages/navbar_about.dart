import 'package:flutter/material.dart';

import '../../Resources/images.dart';
import '../../utils/panel_utils.dart';

class NavBarAbout extends StatelessWidget {
  NavBarAbout({super.key});
  final panelUtils = PanelUtils();

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.zero, children: <Widget>[
      panelUtils.buildHeader(context),
      Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 30, 5),
          child: Column(children: [
            const Image(image: AssetImage(Images.ao1Logo)),
            Text(
              "Arcadis Ost 1 is a 257 MW offshore wind farm developed by Parkwind Ost GmbH. The wind farm will be located in the Baltic Sea, northeast of the island of Rügen in Germany.\n",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              "Scheduled for completion in late 2023, the project is committed to the highest standards and will be using state of the art construction methods for the installation of some of the world’s biggest wind turbines.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ])),
      Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        margin: const EdgeInsets.fromLTRB(100, 5, 100, 5),
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
        alignment: Alignment.center,
      )
    ]);
  }
}
