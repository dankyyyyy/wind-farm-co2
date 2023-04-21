import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/wind_farm.dart';
import '../../models/wind_farm_analytics.dart';

class HomeChart extends StatelessWidget {
  final WindFarm? windFarm;
  final DateTime startDate = DateTime.now().subtract(const Duration(days: 7));
  final DateTime endDate = DateTime.now().subtract(const Duration(days: 1));

  HomeChart(this.windFarm, {super.key});

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
              reservedSize: 20,
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
            dashArray: [12, 8],
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
    for (var i = 0; i < daysBetween(); i++) {
      if (windFarm!.analytics == null || windFarm!.analytics!.isEmpty) {
        barChartData.add(generateGroupData(i + 1, 0, 0));
      } else {
        var analytic = dailyAnalytic(startDate.add(Duration(days: i)));

        if (analytic == null) {
          barChartData.add(generateGroupData(i + 1, 0, 0));
        } else {
          barChartData.add(generateGroupData(analytic.date!.weekday,
              analytic.vesselsTotal, analytic.helicoptersTotal));
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
          width: 20,
          borderRadius: helicopters == 0
              ? const BorderRadius.vertical(top: Radius.circular(5))
              : BorderRadius.zero,
        ),
        BarChartRodData(
          fromY: vessels,
          toY: vessels + helicopters,
          color: heliColor,
          width: 20,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12);
    String text;
    if (daysBetween() < 8) {
      switch (value.toInt()) {
        case 1:
          text = 'Mon';
          break;
        case 2:
          text = 'Tue';
          break;
        case 3:
          text = 'Wed';
          break;
        case 4:
          text = 'Thu';
          break;
        case 5:
          text = 'Fri';
          break;
        case 6:
          text = 'Sat';
          break;
        case 7:
          text = 'Sun';
          break;
        default:
          text = '';
      }
    } else {
      text = value.toString();
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
      fontSize: 12,
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
    for (int i = 0; i < daysBetween(); i++) {
      WindFarmDailyAnalytics? analytic =
          dailyAnalytic(startDate.add(Duration(days: i)));
      if (analytic != null) {
        double total = analytic.helicoptersTotal + analytic.vesselsTotal;
        max = total > max ? total : max;
      }
    }
    return max * 1.2;
  }

  int daysBetween() {
    int days = endDate.difference(startDate).inDays + 1;
    return days;
  }
}
