import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/data_access_provider.dart';
import '../../utils/panel_utils.dart';

class NavBarComparisons extends StatefulWidget {
  const NavBarComparisons({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBarComparisons> createState() => NavBarComparisonsState();
}

class NavBarComparisonsState extends State<NavBarComparisons> {
  final panelUtils = PanelUtils();

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
        : ListView(padding: EdgeInsets.zero, children: <Widget>[
            panelUtils.buildHeader(context, selectedWindfarm),
            const Text(
              "TBA: Comparisons",
              textAlign: TextAlign.center,
            )
          ]);
  }
}
