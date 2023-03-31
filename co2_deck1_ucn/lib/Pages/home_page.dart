import 'package:co2_deck1_ucn/Widgets/menu_button.dart';
import 'package:co2_deck1_ucn/Widgets/menu_drawer.dart';
import 'package:co2_deck1_ucn/Widgets/wf_details/ao1_details.dart';
import 'package:co2_deck1_ucn/Widgets/wf_map.dart';
import 'package:co2_deck1_ucn/providers/data_access.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.8;

    WindfarmDataAccess dataAccess = WindfarmDataAccess();

    return Scaffold(
      drawer: const MenuDrawer(),
      body: SlidingUpPanel(
        controller: panelController,
        minHeight: panelHeightClosed,
        maxHeight: panelHeightOpen,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        body: WF_Map(dataAccess.getWindFarmsList),
        panelBuilder: (controller) => AO1Details(
          scrollController: controller,
          panelController: panelController,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Builder(
        builder: (context) => MenuButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    );
  }
}
