import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'wf_chart.dart';

class DetailsMenu extends StatelessWidget {
  final ScrollController scrollController;
  final PanelController panelController;

  const DetailsMenu({
    Key? key,
    required this.scrollController,
    required this.panelController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        controller: scrollController,
        children: <Widget>[
          const SizedBox(height: 12),
          buildDragHandle(),
          const SizedBox(height: 18),
          const Center(
            child: Text(
              'Arcadis Ost 1',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
                margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                child: const Text(
                  "< Week 10 >",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.calendar_month_outlined,
                    color: Colors.black),
              )
            ],
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              height: 400,
              child: const WindFarmChart(),
            ),
          ),
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 5, 30, 5),
            child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed massa eget elit lacinia mattis. Maecenas eleifend, odio vel interdum scelerisque, turpis diam commodo ipsum, eget ultricies justo quam non ipsum. Etiam fringilla dolor in sem consectetur, ut sollicitudin neque varius. Morbi egestas lacinia urna. Curabitur eu commodo magna, non fermentum augue. Sed malesuada enim iaculis, porta nibh sit amet, gravida felis. Aliquam sed lacinia nisi. Etiam gravida egestas purus ut pretium. Duis vel pellentesque neque, et luctus velit. Nunc malesuada diam vitae nibh placerat lobortis. Fusce dictum commodo dui. Curabitur semper arcu ac viverra posuere."),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            margin: const EdgeInsets.fromLTRB(100, 5, 100, 5),
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Fleet",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 5,),
                Icon(Icons.agriculture),
              ],
            ),
          ),
        ],
      );

  Widget buildInfographics() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[],
        ),
      );

  void showPanel() {
    panelController.show();
  }

  Widget buildDragHandle() => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 124, 123, 123),
            ),
          ),
        ),
      );

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  void togglePanelVisibility() => panelController.isPanelShown
      ? panelController.hide()
      : panelController.show();
}
