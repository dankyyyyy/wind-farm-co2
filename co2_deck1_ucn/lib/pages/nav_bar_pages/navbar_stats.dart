import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../providers/data_access_provider.dart';
import '../../providers/theme_provider.dart';
import 'package:co2_deck1_ucn/widgets/wf_chart.dart';

import '../../utils/panel_utils.dart';

class NavBarStats extends StatefulWidget {
  NavBarStats({
    Key? key,
  }) : super(key: key);
  final panelUtils = PanelUtils();

  @override
  State<NavBarStats> createState() => NavBarStatsState();
}

class NavBarStatsState extends State<NavBarStats> {
  DateTime _pickedDate = DateTime.now().subtract(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final panelUtils = PanelUtils();
    final windfarmData = Provider.of<DataAccessProvider>(context);
    final selectedWindfarmId = windfarmData.selectedWindfarmId;
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
                child: Text("Week ${_weekNumber(_pickedDate)}",
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              GestureDetector(
                  onTap: _showDatePicker,
                  child: CircleAvatar(
                    backgroundColor:
                        themeProvider.getTheme().brightness == Brightness.dark
                            ? const Color.fromRGBO(54, 80, 126, 1)
                            : Colors.grey[300],
                    child: Icon(Icons.calendar_month_outlined,
                        color: themeProvider.getTheme().brightness ==
                                Brightness.dark
                            ? Colors.white
                            : Colors.black),
                  )),
            ]),
            AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  height: 400,
                  child: const WindFarmChart(),
                )),
            const SizedBox(height: 18),
            buildLegend(),
          ]);
  }

//Additional options & methods
  Widget buildInfographics() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[]));

  Widget buildLegend() => AspectRatio(
      aspectRatio: 16,
      child: Row(children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(90, 5, 5, 2),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(15, 158, 227, 1),
              radius: 8.0,
            )),
        Text(
          'Vessels',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Padding(
            padding: EdgeInsets.fromLTRB(70, 5, 5, 2),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(62, 201, 247, 1),
              radius: 8.0,
            )),
        Text(
          'Helicopters',
          style: Theme.of(context).textTheme.bodySmall,
        )
      ]));

  // date picker and date help methods
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _pickedDate = pickedDate;
      });
    });
  }

  int _numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
  int _weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = _numOfWeeks(date.year - 1);
    } else if (woy > _numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }
}
