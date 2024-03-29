import 'package:co2_deck1_ucn/view/widgets/system/home_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:co2_deck1_ucn/controller/utils/size_config.dart';
import 'package:co2_deck1_ucn/model/wind_farm.dart';
import 'package:co2_deck1_ucn/controller/providers/data_access_provider.dart';
import 'package:co2_deck1_ucn/controller/utils/panel_utils.dart';
import 'package:co2_deck1_ucn/view/widgets/charts/home_chart.dart';

class NavBarHome extends StatefulWidget {
  const NavBarHome({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBarHome> createState() => NavBarHomeState();
}

class NavBarHomeState extends State<NavBarHome> {
  final panelUtils = PanelUtils();
  final panelController = PanelController();

  late final DataAccessProvider windfarmData;
  @override
  void initState() {
    super.initState();
    DataAccessProvider tempWindfarmData =
        Provider.of<DataAccessProvider>(context, listen: false);
    if (tempWindfarmData.selectedWindfarmId.isNotEmpty) {
      tempWindfarmData.getAnalytics(tempWindfarmData.selectedWindfarmId);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<DataAccessProvider>(builder: (context, snapshot, child) {
      if (snapshot.selectedWindfarmId.isEmpty) {
        return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Text(
                  "No windfarm selected",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ]);
      } else {
        return Column(children: [
          panelUtils.buildHeader(
            context,
            snapshot.getWindFarmById(snapshot.selectedWindfarmId),
          ),
          Expanded(
              child: ListView(
            controller: HomePanelState().scrollController,
            children: <Widget>[
              buildQuickDetailsOnCards(
                snapshot.getWindFarmById(snapshot.selectedWindfarmId),
              ),
              Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
                      child: Column(children: [
                        const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Maintenance CO₂ emissions",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(height: 18),
                        Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            margin: const EdgeInsets.fromLTRB(12, 0, 12, 30),
                            color: Colors.grey[400],
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 5, 40, 5),
                                child: Text(
                                  "7 Day Summary",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ))),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 200,
                                  child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 20, 0),
                                          height: 400,
                                          child: snapshot.isLoading
                                              ? const CircularProgressIndicator()
                                              : HomeChart(snapshot
                                                  .getWindFarmById(snapshot
                                                      .selectedWindfarmId))))),
                            ]),
                        const SizedBox(height: 18),
                        buildLegend(),
                      ]))),
              Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 15, 15, 15),
                      child: Row(children: const [
                        Icon(Icons.info_outline),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text(
                          "Metric tons of CO₂ emitted by helicopters and vessels during maintainance of the windfarm. The windfarm itself is not emitting any CO₂.",
                          style: TextStyle(fontSize: 16),
                        ))
                      ])))
            ],
          ))
        ]);
      }
    });
  }

// Additional Methods
  Widget buildLegend() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(children: [
          const CircleAvatar(
            backgroundColor: Color.fromRGBO(15, 158, 227, 1),
            radius: 8.0,
          ),
          const SizedBox(width: 8),
          Text('Vessels', style: Theme.of(context).textTheme.bodySmall)
        ]),
        Row(children: [
          const CircleAvatar(
              backgroundColor: Color.fromRGBO(62, 201, 247, 1), radius: 8.0),
          const SizedBox(width: 8),
          Text('Helicopters', style: Theme.of(context).textTheme.bodySmall)
        ])
      ]);

  buildQuickDetailsOnCards(WindFarm? windFarm) => Container(
      padding: const EdgeInsets.all(10),
      child: windFarm == null
          ? const Text(
              "wind farm is null",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          : Column(children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    smallCard("${windFarm.windTurbines}", "windturbines"),
                    smallCard(
                        "${(windFarm.power! % 1) == 0 ? windFarm.power?.toInt() : windFarm.power} MW",
                        "power output")
                  ])
            ]));

  Widget smallCard(String upperText, String lowerText) {
    return SizedBox(
      width: 0.45,
      height: 0.3,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              upperText,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            Text(
              lowerText,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
