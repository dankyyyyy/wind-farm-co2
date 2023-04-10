import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import 'package:co2_deck1_ucn/widgets/wf_chart.dart';

import '../../utils/panel_utils.dart';

class NavBarStats extends StatelessWidget {
  NavBarStats({super.key});
  final panelUtils = PanelUtils();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return ListView(padding: EdgeInsets.zero, children: <Widget>[
      panelUtils.buildHeader(context),
      const SizedBox(height: 5),
      panelUtils.buildQuickDetails(),
      const SizedBox(height: 18),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            decoration: BoxDecoration(
                color: themeProvider.getTheme().brightness == Brightness.dark
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
    ]);
  }

//Additional options & methods
  Widget buildInfographics() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[]));
}
