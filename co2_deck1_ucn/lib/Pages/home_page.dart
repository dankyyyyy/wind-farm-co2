import 'package:co2_deck1_ucn/Widgets/details_menu.dart';
import 'package:co2_deck1_ucn/Widgets/wf_map.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.8;

    return Scaffold(
      body: SlidingUpPanel(
        controller: panelController,
        minHeight: panelHeightClosed,
        maxHeight: panelHeightOpen,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        body: WF_Map(),
        panelBuilder: (controller) => DetailsMenu(
          scrollController: controller,
          panelController: panelController,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
  }

  void togglePanelVisibility() => panelController.isPanelShown
      ? panelController.hide()
      : panelController.show();
}
