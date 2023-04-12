import 'package:co2_deck1_ucn/pages/nav_bar_pages/navbar_about.dart';
import 'package:co2_deck1_ucn/pages/nav_bar_pages/navbar_comparisons.dart';
import 'package:co2_deck1_ucn/pages/nav_bar_pages/navbar_home.dart';
import 'package:co2_deck1_ucn/pages/nav_bar_pages/navbar_stats.dart';
import 'package:co2_deck1_ucn/providers/data_access_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Resources/menu_icons.dart';
import '../../providers/theme_provider.dart';
import '../../utils/themes.dart';
import '../wf_map.dart';

class HomePanel extends StatefulWidget {
  const HomePanel({super.key});

  @override
  HomePanelState createState() => HomePanelState();
}

class HomePanelState extends State<HomePanel> {
  final panelController = PanelController();
  final scrollController = ScrollController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    // size settings for the sliding up panel
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.095;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.7;

    // providers
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final dataAccessProvider = Provider.of<DataAccessProvider>(context);

    return Stack(
      children: <Widget>[
        WindFarmMap(
          onWindFarmSelected: (windfarmId) => {
            setState(() {
              dataAccessProvider.selectedWindfarmId = windfarmId;
              panelController.animatePanelToPosition(0.21,
                  duration: const Duration(
                      milliseconds: 350)); // open the sliding panel
            })
          },
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                SlidingUpPanel(
                  color: themeProvider.getTheme().brightness == Brightness.dark
                      ? const Color.fromRGBO(46, 46, 46, 1)
                      : Colors.white,
                  controller: panelController,
                  minHeight: panelHeightClosed,
                  maxHeight: panelHeightOpen,
                  parallaxEnabled: true,
                  parallaxOffset: 0.5,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                  panelBuilder: (controller) => (navbarPages[index]),
                ),
                NavigationBarTheme(
                  data: themeProvider.getTheme().brightness == Brightness.dark
                      ? darkTheme.navigationBarTheme
                      : lightTheme.navigationBarTheme,
                  child: NavigationBar(
                      selectedIndex: index,
                      labelBehavior:
                          NavigationDestinationLabelBehavior.onlyShowSelected,
                      animationDuration: const Duration(seconds: 1),
                      onDestinationSelected: (index) =>
                          setState(() => this.index = index),
                      destinations: [
                        _buildNavigationDestination(
                          icon: themeProvider.getTheme().brightness ==
                                  Brightness.dark
                              ? const AssetImage(MenuIcons.darkHome)
                              : const AssetImage(MenuIcons.home),
                          selectedIcon: const AssetImage(MenuIcons.activeHome),
                          label: 'Home',
                        ),
                        _buildNavigationDestination(
                          icon: themeProvider.getTheme().brightness ==
                                  Brightness.dark
                              ? const AssetImage(MenuIcons.darkCompare)
                              : const AssetImage(MenuIcons.compare),
                          selectedIcon:
                              const AssetImage(MenuIcons.activeCompare),
                          label: 'Stats',
                        ),
                        _buildNavigationDestination(
                          icon: themeProvider.getTheme().brightness ==
                                  Brightness.dark
                              ? const AssetImage(MenuIcons.darkComparisons)
                              : const AssetImage(MenuIcons.comparisons),
                          selectedIcon:
                              const AssetImage(MenuIcons.activeComparisons),
                          label: 'Comparisons',
                        ),
                        _buildNavigationDestination(
                          icon: themeProvider.getTheme().brightness ==
                                  Brightness.dark
                              ? const AssetImage(MenuIcons.darkAbout)
                              : const AssetImage(MenuIcons.about),
                          selectedIcon: const AssetImage(MenuIcons.activeAbout),
                          label: 'About',
                        )
                      ]),
                )
              ],
            ))
      ],
    );
  }

  // List of Pages
  static List<Widget> navbarPages = <Widget>[
    const NavBarHome(),
    NavBarStats(),
    const NavBarComparisons(),
    const NavBarAbout(),
  ];

  //Additional options & methods

  Widget _buildNavigationDestination({
    required ImageProvider<Object> icon,
    required ImageProvider<Object> selectedIcon,
    required String label,
  }) {
    return NavigationDestination(
      icon: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: icon,
              ))),
      selectedIcon: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: selectedIcon,
              ))),
      label: label,
    );
  }

  void updateWindFarmData(String windFarmId) {
    setState(() {
      DataAccessProvider().selectedWindfarmId = windFarmId;
    });
  }
}
