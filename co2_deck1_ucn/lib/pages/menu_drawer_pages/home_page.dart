import 'package:co2_deck1_ucn/Widgets/system/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/data_access_provider.dart';
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
