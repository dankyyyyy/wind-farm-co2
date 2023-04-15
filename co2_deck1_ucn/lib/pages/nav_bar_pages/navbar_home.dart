import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../models/wind_farm.dart';
import '../../providers/data_access_provider.dart';
import '../../utils/panel_utils.dart';

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

  @override
  Widget build(BuildContext context) {
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
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            panelUtils.buildHeader(
                context, snapshot.getWindFarmById(snapshot.selectedWindfarmId)),
            buildQuickDetails(
                snapshot.getWindFarmById(snapshot.selectedWindfarmId), 0),
          ],
        );
      }
    });
  }

// Additional Methods
  buildQuickDetails(WindFarm? windFarm, double ytd) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: windFarm == null
            ? const Text(
                "wind farm is null",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: [
                    Text(
                      "${windFarm.windTurbines}x ${windFarm.windTurbinesModel}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      " windturbines",
                      style: TextStyle(fontSize: 16),
                    )
                  ]),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "${windFarm.power} MW",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        " power output",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '$ytd tons ',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "CO₂ emitted",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ],
              ),
      );
}
