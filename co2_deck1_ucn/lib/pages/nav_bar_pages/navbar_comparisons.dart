import 'package:co2_deck1_ucn/Widgets/comparison_chart.dart';
import 'package:co2_deck1_ucn/utils/comparison_calculations.dart';
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
  /*late final DataAccessProvider windfarmData;
  @override
  void initState() {
    super.initState();
    DataAccessProvider tempWindfarmData =
        Provider.of<DataAccessProvider>(context, listen: false);
    if (tempWindfarmData.selectedWindfarmId.isNotEmpty) {
      tempWindfarmData.getAnalytics(tempWindfarmData.selectedWindfarmId);
    }
  }*/
}

class NavBarComparisonsState extends State<NavBarComparisons> {
  final panelUtils = PanelUtils();

  get coalEmissions => Calculations().co2EmittedCoal(1, 27, 9.5);
  get lngEmissions => Calculations().co2EmittedLNG(1, 27, 9.5);
  get totalEmissionsLNG =>
      Calculations().totalEmissionsLNG(1, 27, 9.5, 0.65, 50, 0);
  get totalEmissionsCoal =>
      Calculations().totalEmissionsCoal(1, 27, 9.5, 0.65, 50, 0);

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
            AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  height: 400,
                  child: ComparisonChart(
                    lngEmissions: lngEmissions,
                    coalEmissions: coalEmissions,
                    totalEmissionsLNG: totalEmissionsLNG,
                    totalEmissionsCoal: totalEmissionsCoal,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: buildLegend(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: buildLegend2(),
            )
          ]);
  }

  Widget buildLegend() => AspectRatio(
      aspectRatio: 16,
      child: Row(children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(30, 5, 5, 2),
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 237, 23, 44),
              radius: 8.0,
            )),
        Text(
          'Coal Plant',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Padding(
            padding: EdgeInsets.fromLTRB(100, 5, 5, 2),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(62, 201, 247, 1),
              radius: 8.0,
            )),
        Text(
          'Liquid Gas Energy',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ]));

  Widget buildLegend2() => AspectRatio(
      aspectRatio: 16,
      child: Row(children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(30, 5, 5, 2),
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 43, 230, 43),
              radius: 8.0,
            )),
        Text(
          'Wind farm + LNG',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Padding(
            padding: EdgeInsets.fromLTRB(47, 5, 5, 2),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(247, 182, 62, 1),
              radius: 8.0,
            )),
        Text(
          'Wind farm + COAL',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ]));
}
