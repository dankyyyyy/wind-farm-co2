import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelUtils {
  ScrollController scrollController = ScrollController();
  PanelController panelController = PanelController();

  Widget buildHeader(BuildContext context) => SizedBox(
      height: 200,
      child: ListView(
          padding: EdgeInsets.zero,
          controller: scrollController,
          children: <Widget>[
            const SizedBox(height: 12),
            buildDragHandle(),
            const SizedBox(height: 18),
            Center(
                child: Text(
              'ARCADIS OST 1',
              style: Theme.of(context).textTheme.displayMedium,
            )),
          ]));

  Widget buildDragHandle() => GestureDetector(
      onTap: togglePanel,
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

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  void togglePanelVisibility() => panelController.isPanelShown
      ? panelController.hide()
      : panelController.show();
}