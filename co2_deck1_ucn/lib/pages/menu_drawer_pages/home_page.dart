import 'package:co2_deck1_ucn/Widgets/system/menu_drawer.dart';
import 'package:flutter/material.dart';
import '../../Widgets/wf_map.dart';
import '../../providers/data_access.dart';
import '../../widgets/system/home_panel.dart';
import '../../Widgets/system/menu_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // data source
    WindfarmDataAccess dataAccess = WindfarmDataAccess();

    return Scaffold(
        body: Stack(
          children: [
            WF_Map(dataAccess.getWindFarmsList),
            const HomePanel(),
          ],
        ),
        drawer: const MenuDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Builder(
            builder: (context) => MenuButton(onPressed: () {
                  Scaffold.of(context).openDrawer();
                })));
  }
}
