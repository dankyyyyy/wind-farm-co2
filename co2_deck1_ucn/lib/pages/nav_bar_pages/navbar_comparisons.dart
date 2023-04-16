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
}

class NavBarComparisonsState extends State<NavBarComparisons> {
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

  final panelUtils = PanelUtils();

  @override
  Widget build(BuildContext context) {
    return Consumer<DataAccessProvider>(builder: (context, snapshot, child) {
      int? turbines =
          snapshot.getWindFarmById(snapshot.selectedWindfarmId)?.windTurbines;
      double? power =
          snapshot.getWindFarmById(snapshot.selectedWindfarmId)?.power;

      double coalEmissions =
          Calculations().co2EmittedCoal(1, turbines!, power!);
      double lngEmissions = Calculations().co2EmittedLNG(1, turbines, power);
      double totalEmissionsLNG =
          Calculations().totalEmissionsLNG(1, turbines, power, 0.65, 50, 0);
      double totalEmissionsCoal =
          Calculations().totalEmissionsCoal(1, turbines, power, 0.65, 50, 0);

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
        return ListView(padding: EdgeInsets.zero, children: <Widget>[
          panelUtils.buildHeader(
              context, snapshot.getWindFarmById(snapshot.selectedWindfarmId)),
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
    });
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
