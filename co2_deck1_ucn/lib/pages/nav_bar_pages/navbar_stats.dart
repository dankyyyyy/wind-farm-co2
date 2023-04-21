import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../providers/data_access_provider.dart';
import 'package:co2_deck1_ucn/widgets/charts/wf_chart.dart';

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
        return Column(children: [
          panelUtils.buildHeader(
            context,
            snapshot.getWindFarmById(snapshot.selectedWindfarmId),
          ),
          Expanded(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.fromLTRB(12, 5, 12, 12),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "CO₂ emissions in tons",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      margin: const EdgeInsets.fromLTRB(12, 5, 12, 10),
                      color: Colors.grey[400],
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _monthBack,
                              child: const Icon(Icons.arrow_back_ios,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: _showDatePicker,
                              child: Text(
                                DateFormat("MMMM yyyy").format(_pickedDate),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: _monthForward,
                              child: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          height: 400,
                          child: WindFarmChart(
                              snapshot
                                  .getWindFarmById(snapshot.selectedWindfarmId),
                              snapshot.startDate,
                              snapshot.endDate),
                        )),
                    const SizedBox(height: 18),
                    buildLegend(),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.fromLTRB(12, 5, 12, 12),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 15, 15, 15),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        "This chart depicts values in metric tons of CO₂ emitted by helicopters and vessels during maintainance of the windfarm. The windfarm itself is not emitting any CO₂.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]))
        ]);
      }
    });
  }

//Additional options & methods
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
        ]),
      ]);

  // date picker and date help methods
  void _showDatePicker() {
    showMonthYearPicker(
      context: context,
      initialDate: _pickedDate,
      firstDate: DateTime(2022, 5),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      DataAccessProvider windfarmData =
          Provider.of<DataAccessProvider>(context, listen: false);
      windfarmData.startDate = DateTime(pickedDate.year, pickedDate.month, 1);
      windfarmData.endDate = DateTime(pickedDate.year, pickedDate.month,
          DateUtils.getDaysInMonth(pickedDate.year, pickedDate.month));
      windfarmData.getAnalytics(windfarmData.selectedWindfarmId, isInit: false);
      setState(() {
        _pickedDate = pickedDate;
      });
    });
  }

  void _monthForward() {
    if (_pickedDate
        .isBefore(DateTime(DateTime.now().year, DateTime.now().month))) {
      DateTime startDate = DateTime(
          _pickedDate.month == 12 ? _pickedDate.year + 1 : _pickedDate.year,
          _pickedDate.month == 12 ? 1 : _pickedDate.month + 1,
          1);
      updateProvider(
          startDate,
          DateTime(startDate.year, startDate.month,
              DateUtils.getDaysInMonth(startDate.year, startDate.month)));
      setState(() {
        _pickedDate = startDate;
      });
    }
  }

  void _monthBack() {
    if (_pickedDate.isAfter(DateTime(2022, 4))) {
      DateTime startDate = DateTime(
          _pickedDate.month == 1 ? _pickedDate.year - 1 : _pickedDate.year,
          _pickedDate.month == 1 ? 12 : _pickedDate.month - 1,
          1);
      updateProvider(
          startDate,
          DateTime(startDate.year, startDate.month,
              DateUtils.getDaysInMonth(startDate.year, startDate.month)));
      setState(() {
        _pickedDate = startDate;
      });
    }
  }

  updateProvider(DateTime startDate, DateTime endDate) {
    DataAccessProvider windFarmProvider =
        Provider.of<DataAccessProvider>(context, listen: false);
    windFarmProvider.startDate = startDate;
    windFarmProvider.endDate = endDate;
    windFarmProvider.getAnalytics(windFarmProvider.selectedWindfarmId,
        isInit: false);
  }
}
