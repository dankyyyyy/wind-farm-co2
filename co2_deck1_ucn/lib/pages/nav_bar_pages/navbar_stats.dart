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
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final panelUtils = PanelUtils();

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
        return ListView(padding: EdgeInsets.zero, children: <Widget>[
          panelUtils.buildHeader(
              context, snapshot.getWindFarmById(snapshot.selectedWindfarmId)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: _showDatePicker,
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: _showDatePicker,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: Text(
                  DateFormat("MMMM yyyy").format(_pickedDate),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: _showDatePicker,
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.arrow_forward, color: Colors.black),
              ),
            ),
          ]),
          AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                height: 400,
                child: WindFarmChart(
                    snapshot.getWindFarmById(snapshot.selectedWindfarmId),
                    snapshot.startDate,
                    snapshot.endDate),
              )),
          const SizedBox(height: 18),
          buildLegend(),
        ]);
      }
    });
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
      DataAccessProvider WindfarmData =
          Provider.of<DataAccessProvider>(context, listen: false);
      WindfarmData.startDate = pickedDate.subtract(Duration(days: 7));
      WindfarmData.endDate = pickedDate;
      WindfarmData.getAnalytics(WindfarmData.selectedWindfarmId, isInit: false);

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
