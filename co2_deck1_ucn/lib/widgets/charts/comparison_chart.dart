import 'dart:math';

import 'package:co2_deck1_ucn/models/wind_farm.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/wind_farm_analytics.dart';
import '../../utils/comparison_calculations.dart';

class ComparisonChart extends StatelessWidget {
  final WindFarm? windFarm;
  final DateTime startDate;
  final DateTime endDate;

  const ComparisonChart(this.windFarm, this.startDate, this.endDate,
      {super.key});

  final Color coalColor = const Color.fromARGB(255, 237, 23, 44);
  final Color lngColor = const Color.fromRGBO(62, 201, 247, 1);
  final Color windColor = const Color.fromARGB(255, 43, 230, 43);

  static double _maxy = 0;

  @override
  Widget build(BuildContext context) {
    return windFarm == null
        ? const Text("Windfarm is null")
        : BarChart(BarChartData(
            alignment: BarChartAlignment.spaceEvenly,
            titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: leftTitles,
                )),
                rightTitles: AxisTitles(),
                topTitles: AxisTitles(),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: bottomTitles,
                  reservedSize: 20,
                ))),
            barTouchData: BarTouchData(enabled: false),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              show: true,
              checkToShowHorizontalLine: (value) => value % 5 == 0,
              drawHorizontalLine: true,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey[350]!,
                strokeWidth: 1,
                dashArray: [12, 8],
              ),
              drawVerticalLine: false,
            ),
            barGroups: generateData(),
            groupsSpace: 10,
            maxY: _maxy,
          ));
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Coal plant';
        break;
      case 1:
        text = 'LNG plant';
        break;
      case 2:
        text = 'Wind farm';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          text,
          style: style,
        ));
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 12,
    );
    return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          meta.formattedValue,
          style: style,
        ));
  }

  List<BarChartGroupData> generateData() {
    List<BarChartGroupData> barChartData = List.empty(growable: true);

    int turbines = windFarm?.windTurbines ?? 0;
    double power = windFarm?.power ?? 0;

    double week1 = 0;
    double week2 = 0;
    double week3 = 0;
    double week4 = 0;
    double week5 = 0;
    double vessels = 0;
    double helicopters = 0;

    var days = daysBetween();

    for (var i = 1; i < days; i++) {
      if (windFarm?.analytics != null || windFarm!.analytics!.isNotEmpty) {
        var analytic = dailyAnalytic(startDate.add(Duration(days: i)));
        if (i % 7 != 0 && i != days - 1) {
          vessels += analytic?.vesselsTotal ?? 0;
          helicopters += analytic?.helicoptersTotal ?? 0;
        } else {
          switch ((i / 7).ceil()) {
            case 1:
              week1 = vessels + helicopters;
              break;
            case 2:
              week2 = vessels + helicopters;
              break;
            case 3:
              week3 = vessels + helicopters;
              break;
            case 4:
              week4 = vessels + helicopters;
              break;
            case 5:
              week5 = vessels + helicopters;
              break;
            default:
          }
          vessels = 0;
          helicopters = 0;
        }
      }
    }

    double coalEmissions = Calculations().co2EmittedCoal(days, turbines, power);
    double lngEmissions = Calculations().co2EmittedLNG(days, turbines, power);

    barChartData.add(BarChartGroupData(x: 0, groupVertically: true, barRods: [
      BarChartRodData(
        fromY: 0,
        toY: coalEmissions,
        color: coalColor,
        width: 30,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
      )
    ]));

    barChartData.add(BarChartGroupData(x: 1, groupVertically: true, barRods: [
      BarChartRodData(
        fromY: 0,
        toY: lngEmissions,
        color: lngColor,
        width: 30,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
      )
    ]));

    barChartData.add(BarChartGroupData(x: 2, groupVertically: true, barRods: [
      BarChartRodData(
        fromY: 0,
        toY: week1,
        color: windColor,
        width: 30,
        borderRadius: week2 + week3 + week4 + week5 == 0
            ? const BorderRadius.vertical(top: Radius.circular(5))
            : BorderRadius.zero,
      ),
      BarChartRodData(
        fromY: week1,
        toY: week1 + week2,
        color: windColor,
        width: 30,
        borderRadius: week3 + week4 + week5 == 0
            ? const BorderRadius.vertical(top: Radius.circular(5))
            : BorderRadius.zero,
      ),
      BarChartRodData(
        fromY: week1 + week2,
        toY: week1 + week2 + week3,
        color: windColor,
        width: 30,
        borderRadius: week4 + week5 == 0
            ? const BorderRadius.vertical(top: Radius.circular(5))
            : BorderRadius.zero,
      ),
      BarChartRodData(
        fromY: week1 + week2 + week3,
        toY: week1 + week2 + week3 + week4,
        color: windColor,
        width: 30,
        borderRadius: week5 == 0
            ? const BorderRadius.vertical(top: Radius.circular(5))
            : BorderRadius.zero,
      ),
      BarChartRodData(
        fromY: week1 + week2 + week3 + week4,
        toY: week1 + week2 + week3 + week4 + week5,
        color: windColor,
        width: 30,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
      )
    ]));
    double weeks = week1 + week2 + week3 + week4 + week5;
    _maxy = max(max(weeks, coalEmissions), lngEmissions);
    return barChartData;
  }

  WindFarmDailyAnalytics? dailyAnalytic(DateTime date) {
    WindFarmDailyAnalytics? analytic = windFarm!.analytics!
        .cast<WindFarmDailyAnalytics?>()
        .singleWhereOrNull((element) {
      var isSame = isSameDay(element?.date, date);
      return isSame;
    });
    return analytic;
  }

  int daysBetween() {
    int days = endDate.difference(startDate).inDays;
    return days;
  }

  bool isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) {
      return false;
    }
    if (date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year) {
      return true;
    } else {
      return false;
    }
  }
}
