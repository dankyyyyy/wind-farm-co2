import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ComparisonChart extends StatelessWidget {
  final double lngEmissions;
  final double coalEmissions;
  final double totalEmissionsLNG;
  final double totalEmissionsCoal;

  const ComparisonChart({
    Key? key,
    required this.lngEmissions,
    required this.coalEmissions,
    required this.totalEmissionsLNG,
    required this.totalEmissionsCoal,
  }) : super(key: key);

  final Color coalColor = const Color.fromARGB(255, 237, 23, 44);
  final Color lngColor = const Color.fromRGBO(62, 201, 247, 1);
  final Color windColor = const Color.fromARGB(255, 43, 230, 43);
  final Color windCoalColor = const Color.fromARGB(255, 247, 155, 62);

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

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
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
      barGroups: [
        BarChartGroupData(x: 0, groupVertically: true, barRods: [
          BarChartRodData(
            fromY: 0,
            toY: coalEmissions,
            color: coalColor,
            width: 25,
            borderRadius: coalEmissions == 0
                ? const BorderRadius.vertical(top: Radius.circular(5))
                : BorderRadius.zero,
          )
        ]),
        BarChartGroupData(x: 1, groupVertically: true, barRods: [
          BarChartRodData(
              fromY: 0,
              toY: lngEmissions,
              color: lngColor,
              width: 25,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(5))),
        ]),
        BarChartGroupData(
          x: 3,
          groupVertically: true,
          barRods: [
            BarChartRodData(
                fromY: 0,
                toY: totalEmissionsCoal,
                color: windCoalColor,
                width: 25,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(5))),
          ],
        ),
        BarChartGroupData(x: 2, groupVertically: true, barRods: [
          BarChartRodData(
              fromY: 0,
              toY: totalEmissionsLNG,
              color: windColor,
              width: 25,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(5))),
        ])
      ],
      groupsSpace: 10,
      maxY: 5500,
    ));
  }
}
