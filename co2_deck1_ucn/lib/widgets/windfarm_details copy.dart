import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/intl.dart';

import '../models/wind_farm.dart';
import '../providers/windfarms.dart';
import 'wf_chart.dart';

class WindFarmDetails extends StatefulWidget {
  final ScrollController scrollController;
  final PanelController panelController;
  final String selectedWindfarmId;

  const WindFarmDetails({
    Key? key,
    required this.selectedWindfarmId,
    required this.scrollController,
    required this.panelController,
  }) : super(key: key);

  @override
  State<WindFarmDetails> createState() => _WindFarmDetailsState();
}

class _WindFarmDetailsState extends State<WindFarmDetails> {
  DateTime _pickedDate = DateTime.now();
  var _loaded = false;
  WindFarm? selectedWindfarm;

  static Widget dragHandle = Center(
    child: Container(
      width: 60,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 124, 123, 123),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final windfarmData = Provider.of<WindFarms>(context, listen: false);
    if (!windfarmData.isLoading) {
      String startDate = DateFormat("yyyy-MM-dd")
          .format(_pickedDate.subtract(Duration(days: 7)));
      String endDate =
          DateFormat("yyyy-MM-dd").format(mostRecentMonday(_pickedDate));
      if (widget.selectedWindfarmId.isNotEmpty && _loaded != true) {
        // windfarmData
        //     .getAnalytics(widget.selectedWindfarmId, startDate, endDate)
        //     .then((_) => {
        //           selectedWindfarm =
        //               windfarmData.getWindFarmById(widget.selectedWindfarmId),
        //           _loaded = true
        //         });
      }
    }
    double ytd = 0;

    return widget.selectedWindfarmId.isEmpty
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: Text(
                    "No windfarm selected",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'BebasNeue',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ])
        : ListView(
            padding: EdgeInsets.zero,
            controller: widget.scrollController,
            children: <Widget>[
              const SizedBox(height: 12),
              dragHandle,
              const SizedBox(height: 18),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.flag_circle_outlined,
                          color: Colors.black, size: 40),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      selectedWindfarm?.name ?? "",
                      style: const TextStyle(
                          fontSize: 40,
                          fontFamily: 'BebasNeue',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              buildQuickDetails(selectedWindfarm, ytd),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _showDatePicker,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(
                        "Week ${_weekNumber(_pickedDate)}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _showDatePicker,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.calendar_month_outlined,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 35),
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child:
                        const Icon(Icons.swap_vert_sharp, color: Colors.black),
                  )
                ],
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  height: 400,
                  child: /*_loaded
                      ? WindFarmChart(selectedWindfarm,
                          _pickedDate.subtract(Duration(days: 7)))
                      : */const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                margin: const EdgeInsets.fromLTRB(100, 5, 100, 5),
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [],
                ),
              ),
            ],
          );
  }

  Widget buildQuickDetails(WindFarm? windFarm, double ytd) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: windFarm == null
            ? const Text(
                "wind farm is null",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        "${windFarm.windTurbines}x ${windFarm.windTurbinesModel}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        " windturbines",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
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

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _pickedDate = pickedDate;
        _loaded = false;
      });
    });
  }

  int _numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

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

  DateTime mostRecentMonday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 1));
}
