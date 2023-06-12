import 'package:co2_deck1_ucn/controller/providers/data_access_provider.dart';
import 'package:co2_deck1_ucn/controller/utils/size_config.dart';
import 'package:co2_deck1_ucn/view/widgets/system/home_panel.dart';
import 'package:co2_deck1_ucn/view/widgets/system/menu_button.dart';
import 'package:co2_deck1_ucn/view/widgets/system/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final windfarmData = Provider.of<DataAccessProvider>(context);
    return Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: windfarmData.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : const HomePanel(),
            )
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
