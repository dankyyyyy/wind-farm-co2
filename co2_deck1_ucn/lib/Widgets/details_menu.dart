import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
              'WF Name',
              style: TextStyle(),
            ),
          )
        ],
      );

  Widget buildInfographics() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[],
      ));

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
