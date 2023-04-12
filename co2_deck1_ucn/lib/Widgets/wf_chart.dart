import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/wind_farm.dart';

class WindFarmChart extends StatelessWidget {
  final WindFarm? windFarm;
  final DateTime startDate;
  const WindFarmChart(this.windFarm, this.startDate, {super.key});

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
              reservedSize: 40,
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
        maxY: 60,
      ),
    );
  }

  List<BarChartGroupData> generateData() {
    List<BarChartGroupData> barChartData = List.empty(growable: true);
    for (var i = 0; i < 7; i++) {
      barChartData.add(generateGroupData(
          i,
          windFarm!.analytics!
              .singleWhere(
                  (element) => element.date == startDate.add(Duration(days: i)))
              .vesselsTotal,
          windFarm!.analytics!
              .singleWhere(
                  (element) => element.date == startDate.add(Duration(days: i)))
              .helicoptersTotal));
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
          width: 25,
          borderRadius: helicopters == 0
              ? const BorderRadius.vertical(top: Radius.circular(5))
              : BorderRadius.zero,
        ),
        BarChartRodData(
          fromY: vessels,
          toY: vessels + helicopters,
          color: heliColor,
          width: 25,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
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
}
