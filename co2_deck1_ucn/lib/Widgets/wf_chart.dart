import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/wind_farm.dart';
import '../models/wind_farm_analytics.dart';

class WindFarmChart extends StatelessWidget {
  final WindFarm? windFarm;
  final DateTime startDate;
  final DateTime endDate;
  const WindFarmChart(this.windFarm, this.startDate, this.endDate, {super.key});

  final Color heliColor = const Color.fromRGBO(15, 158, 227, 1);
  final Color vesselsColor = const Color.fromRGBO(62, 201, 247, 1);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 45,
              getTitlesWidget: leftTitles,
            ),
          ),
          rightTitles: AxisTitles(),
          topTitles: AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: bottomTitles,
              reservedSize: 20,
            ),
          ),
        ),
        barTouchData: BarTouchData(enabled: false),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          checkToShowHorizontalLine: (value) => value % 5 == 0,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey[350],
            strokeWidth: 1,
            dashArray: [8, 6],
          ),
          drawVerticalLine: false,
        ),
        barGroups: generateData(),
        groupsSpace: 10,
        maxY: maxy(),
      ),
    );
  }

  List<BarChartGroupData> generateData() {
    List<BarChartGroupData> barChartData = List.empty(growable: true);
    double vessels = 0;
    double helicopters = 0;
    var days = daysBetween();
    for (var i = 1; i < days; i++) {
      if (windFarm!.analytics != null || windFarm!.analytics!.isNotEmpty) {
        var analytic = dailyAnalytic(startDate.add(Duration(days: i)));

        if (i % 7 != 0 && i != days - 1) {
          vessels += analytic?.vesselsTotal ?? 0;
          helicopters += analytic?.helicoptersTotal ?? 0;
        } else {
          barChartData
              .add(generateGroupData((i / 7).ceil(), vessels, helicopters));
          vessels = 0;
          helicopters = 0;
        }
      }
    }
    return barChartData;
  }

  BarChartGroupData generateGroupData(
    int x,
    double vessels,
    double helicopters,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: vessels,
          color: vesselsColor,
          width: daysBetween() % 7 == 0 ? 25 : 20,
          borderRadius: helicopters == 0
              ? const BorderRadius.vertical(top: Radius.circular(5))
              : BorderRadius.zero,
        ),
        BarChartRodData(
          fromY: vessels,
          toY: vessels + helicopters,
          color: heliColor,
          width: daysBetween() % 7 == 0 ? 25 : 20,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12);
    String text;

    switch (value.toInt()) {
      case 1:
        text = 'Week 1';
        break;
      case 2:
        text = 'Week 2';
        break;
      case 3:
        text = 'Week 3';
        break;
      case 4:
        text = 'Week 4';
        break;
      case 5:
        text = 'Week 5';
        break;
      default:
        text = '';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 13,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
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

  WindFarmDailyAnalytics? dailyAnalytic(DateTime date) {
    WindFarmDailyAnalytics? analytic = windFarm!.analytics!
        .cast<WindFarmDailyAnalytics?>()
        .singleWhereOrNull((element) {
      var isSame = isSameDay(element?.date, date);
      return isSame;
    });
    return analytic;
  }

  double maxy() {
    double max = 0;
    double weekly = 0;
    for (int i = 0; i < daysBetween(); i++) {
      WindFarmDailyAnalytics? analytic =
          dailyAnalytic(startDate.add(Duration(days: i)));
      if (analytic != null) {
        if (i % 7 != 0) {
          weekly += analytic.helicoptersTotal + analytic.vesselsTotal;
        } else {
          max = weekly > max ? weekly : max;
          weekly = 0;
        }
      }
    }
    return max * 1.2;
  }

  int daysBetween() {
    int days = endDate.difference(startDate).inDays;
    return days;
  }
}
