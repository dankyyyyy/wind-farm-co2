import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/wind_farm.dart';

class PanelUtils {
  ScrollController scrollController = ScrollController();
  PanelController panelController = PanelController();

  Widget buildHeader(BuildContext context, WindFarm? selectedWindfarm) =>
      SizedBox(
          height: 120,
          child: ListView(
              padding: EdgeInsets.zero,
              controller: scrollController,
              children: <Widget>[
                const SizedBox(height: 12),
                buildDragHandle(),
                const SizedBox(height: 18),
                Center(
                    child: Text(
                  selectedWindfarm?.name ?? "",
                  style: Theme.of(context).textTheme.displayMedium,
                )),
              ]));

  Widget buildDragHandle() => GestureDetector(
      child: Center(
          child: Container(
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 124, 123, 123),
              ))));

  void showPanel() {
    panelController.show();
  }

  void togglePanelVisibility() => panelController.isPanelShown
      ? panelController.hide()
      : panelController.show();
}
