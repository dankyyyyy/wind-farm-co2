import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ComparisonChart extends StatelessWidget {
  final double co2LNG;
  final double co2COAL;
  final double totalEmissions;
  final double totalEmissionsC;

  const ComparisonChart({
    Key? key,
    required this.co2LNG,
    required this.co2COAL,
    required this.totalEmissions,
    required this.totalEmissionsC,
  }) : super(key: key);

  final Color coalColor = const Color.fromARGB(255, 237, 23, 44);
  final Color LNGColor = const Color.fromRGBO(62, 201, 247, 1);
  final Color windColor = const Color.fromARGB(255, 43, 230, 43);
  final Color WindCoalColor = const Color.fromRGBO(247, 182, 62, 1);

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'COAL';
        break;
      case 1:
        text = 'LNG';
        break;
      case 2:
        text = 'WF+LNG';
        break;
      case 3:
        text = 'WF+COAL';
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
              reservedSize: 50,
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
            color: Colors.grey[350]!,
            strokeWidth: 1,
            dashArray: [12, 8],
          ),
          drawVerticalLine: false,
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            groupVertically: true,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: co2COAL,
                color: coalColor,
                width: 25,
                borderRadius: co2COAL == 0
                    ? const BorderRadius.vertical(top: Radius.circular(5))
                    : BorderRadius.zero,
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            groupVertically: true,
            barRods: [
              BarChartRodData(
                  fromY: 0,
                  toY: co2LNG,
                  color: LNGColor,
                  width: 25,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(5))),
            ],
          ),
          BarChartGroupData(
            x: 2,
            groupVertically: true,
            barRods: [
              BarChartRodData(
                  fromY: 0,
                  toY: totalEmissions,
                  color: windColor,
                  width: 25,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(5))),
            ],
          ),
          BarChartGroupData(
            x: 3,
            groupVertically: true,
            barRods: [
              BarChartRodData(
                  fromY: 0,
                  toY: totalEmissionsC,
                  color: WindCoalColor,
                  width: 25,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(5))),
            ],
          ),
        ],
        groupsSpace: 10,
        maxY: 5000,
      ),
    );
  }
}
