import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Resources/images.dart';
import '../wf_chart.dart';

class KriegersFlakDetails extends StatelessWidget {
  final ScrollController scrollController;
  final PanelController panelController;

  const KriegersFlakDetails({
    Key? key,
    required this.scrollController,
    required this.panelController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        controller: scrollController,
        children: <Widget>[
          const SizedBox(height: 12),
          buildDragHandle(),
          const SizedBox(height: 18),
          const Center(
            child: Text(
              'Kriegers Flak',
              style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'BebasNeue',
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          buildQuickDetails(),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
                margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                child: const Text(
                  "< Week 10 >",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.calendar_month_outlined,
                    color: Colors.black),
              )
            ],
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              height: 400,
              child: const WindFarmChart(),
            ),
          ),
          const SizedBox(height: 40),
          const Divider(
            color: Colors.blueGrey,
            indent: 30,
            endIndent: 30,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 30, 5),
            child: Column(
              children: const [
                Image(image: AssetImage(Images.vattenfallLogo)),
                Text(
                  "Kriegers Flak is located in the Baltic Sea, 15-40 kilometres off the Danish coast. The offshore wind farm covers the annual energy consumption of approximately 600,000 households.\n",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "In May 2020, Vattenfall put the first foundation in place at Kriegers Flak, and the first wind turbine was installed at the beginning of 2021. Despite the logistical challenges that the Covid-19 pandemic brought, all 72 turbines were installed on schedule by summer 2021.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            margin: const EdgeInsets.fromLTRB(100, 5, 100, 5),
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
            alignment: Alignment.center,
            /*child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Fleet",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),*/
          ),
        ],
      );

//Additional options & methods
  Widget buildInfographics() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[],
        ),
      );

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
            ),
          ),
        ),
      );

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
        ],
      ));
}
