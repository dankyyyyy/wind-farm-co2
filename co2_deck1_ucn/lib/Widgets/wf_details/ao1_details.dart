import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Resources/images.dart';
import '../../providers/theme_provider.dart';
import '../wf_chart.dart';

class AO1Details extends StatelessWidget {
  final ScrollController scrollController;
  final PanelController panelController;

  const AO1Details({
    Key? key,
    required this.scrollController,
    required this.panelController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return ListView(
        padding: EdgeInsets.zero,
        controller: scrollController,
        children: <Widget>[
          const SizedBox(height: 12),
          buildDragHandle(),
          const SizedBox(height: 18),
          Center(
              child: Text(
            'ARCADIS OST 1',
            style: Theme.of(context).textTheme.displayMedium,
          )),
          const SizedBox(height: 5),
          buildQuickDetails(),
          const SizedBox(height: 18),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                decoration: BoxDecoration(
                    color:
                        themeProvider.getTheme().brightness == Brightness.dark
                            ? const Color.fromRGBO(54, 80, 126, 1)
                            : Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
                margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                child: const Text(
                  "Week 10",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )),
            CircleAvatar(
              backgroundColor:
                  themeProvider.getTheme().brightness == Brightness.dark
                      ? const Color.fromRGBO(54, 80, 126, 1)
                      : Colors.grey[300],
              child: Icon(Icons.calendar_month_outlined,
                  color: themeProvider.getTheme().brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
            )
          ]),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              height: 400,
              child: const WindFarmChart(),
            ),
          ),
          const SizedBox(height: 15),
          AspectRatio(
            aspectRatio: 16,
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(90, 5, 5, 2),
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(15, 158, 227, 1),
                  radius: 8.0,
                ),
              ),
              Text(
                'Vessels',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(70, 5, 5, 2),
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(62, 201, 247, 1),
                  radius: 8.0,
                ),
              ),
              Text(
                'Helicopters',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ]),
          ),
          const SizedBox(height: 15),
          const Divider(
            color: Colors.blueGrey,
            indent: 30,
            endIndent: 30,
            thickness: 1,
          ),
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

//Additional options & methods
  Widget buildInfographics() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[]));

  void showPanel() {
    panelController.show();
  }

  Widget buildDragHandle() => GestureDetector(
      onTap: togglePanel,
      child: Center(
          child: Container(
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 124, 123, 123),
              ))));

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  void togglePanelVisibility() => panelController.isPanelShown
      ? panelController.hide()
      : panelController.show();

  buildQuickDetails() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text('27 x MHI Vestas V174-9.5MW WTG'),
            Text('19km from shore'),
            Text('72t of CO2'),
          ]));
}
