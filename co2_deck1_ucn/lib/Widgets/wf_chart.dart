import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WindFarmChart extends StatelessWidget {
  const WindFarmChart({super.key});

  final Color farmColor = const Color.fromRGBO(134, 234, 232, 1);
  final Color vesselsColor = const Color.fromRGBO(60, 103, 150, 1);
  final Color helicopterColor = const Color.fromRGBO(131, 148, 222, 1);

  BarChartGroupData generateGroupData(
    int x,
    double farm,
    double vessels,
    double helicopters,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: farm,
          color: farmColor,
          width: 25,
          borderRadius: helicopters == 0 && vessels == 0
              ? const BorderRadius.vertical(top: Radius.circular(5))
              : BorderRadius.zero,
        ),
        BarChartRodData(
          fromY: farm,
          toY: farm + vessels,
          color: vesselsColor,
          width: 25,
          borderRadius: helicopters == 0
              ? const BorderRadius.vertical(top: Radius.circular(5))
              : BorderRadius.zero,
        ),
        BarChartRodData(
          fromY: farm + vessels,
          toY: farm + vessels + helicopters,
          color: helicopterColor,
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
        barGroups: [
          generateGroupData(0, 16, 13, 12),
          generateGroupData(1, 15, 15, 17),
          generateGroupData(2, 13, 15, 8),
          generateGroupData(3, 10, 0, 31),
          generateGroupData(4, 7, 12, 8),
          generateGroupData(5, 12, 9, 18),
          generateGroupData(6, 9, 25, 0),
        ],
        groupsSpace: 10,
        maxY: 60,
      ),
    );
  }
}
