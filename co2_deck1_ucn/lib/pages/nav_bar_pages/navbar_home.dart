import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
    final windfarmData = Provider.of<DataAccessProvider>(context);
    final String selectedWindfarmId = windfarmData.selectedWindfarmId;
    final selectedWindfarm = selectedWindfarmId.isNotEmpty
        ? windfarmData.getWindFarmById(selectedWindfarmId)
        : null;
    return selectedWindfarmId.isEmpty
        ? Row(
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
              ])
        : ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              
              panelUtils.buildHeader(context, selectedWindfarm),
              panelUtils.buildQuickDetails(),
            ],
          );
  }
}
