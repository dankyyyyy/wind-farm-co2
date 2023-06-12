import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../pages/menu_drawer_pages/about_page.dart';
import '../../pages/menu_drawer_pages/glossary_page.dart';
import '../../pages/menu_drawer_pages/home_page.dart';
import '../../pages/menu_drawer_pages/settings_page.dart';
import '../../Resources/images.dart';
import '../../Resources/menu_icons.dart';
import '../../providers/data_access_provider.dart';
import '../../providers/selection_provider.dart';
import '../../providers/theme_provider.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final selectionProvider = context.watch<SelectionProvider>();
    final dataAccessProvider =
        Provider.of<DataAccessProvider>(context, listen: false);
    return Drawer(
        child: Builder(
            builder: (context) => ListView(padding: EdgeInsets.zero, children: [
                  Container(
                      margin: const EdgeInsets.only(top: 40, bottom: 30),
                      height: 130,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: themeProvider.getTheme().brightness ==
                                Brightness.dark
                            ? const AssetImage(Images.darkLogo)
                            : const AssetImage(Images.logo),
                        fit: BoxFit.scaleDown,
                      ))),
                  ListTile(
                      selected: selectionProvider.selectedTile == 0,
                      selectedTileColor: selectionProvider.selectedTile == 0
                          ? (themeProvider.getTheme().brightness ==
                                  Brightness.dark
                              ? const Color.fromARGB(255, 85, 98, 105)
                              : const Color.fromARGB(255, 188, 200, 207))
                          : null,
                      leading: CircleAvatar(
                        backgroundImage: selectionProvider.selectedTile == 0
                            ? const AssetImage(MenuIcons.activeHome)
                            : (themeProvider.getTheme().brightness ==
                                    Brightness.dark
                                ? const AssetImage(MenuIcons.darkHome)
                                : const AssetImage(MenuIcons.home)),
                        backgroundColor: Colors.transparent,
                        radius: 13,
                      ),
                      title: Text(
                        'Home',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () {
                        dataAccessProvider.clearData();
                        context.read<SelectionProvider>().selectedTile = 0;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }),
                  ListTile(
                      selected: selectionProvider.selectedTile == 1,
                      selectedTileColor: selectionProvider.selectedTile == 1
                          ? (themeProvider.getTheme().brightness ==
                                  Brightness.dark
                              ? const Color.fromARGB(255, 85, 98, 105)
                              : const Color.fromARGB(255, 188, 200, 207))
                          : null,
                      leading: CircleAvatar(
                          backgroundImage: selectionProvider.selectedTile == 1
                              ? const AssetImage(MenuIcons.activeGlossary)
                              : (themeProvider.getTheme().brightness ==
                                      Brightness.dark
                                  ? const AssetImage(MenuIcons.darkGlossary)
                                  : const AssetImage(MenuIcons.glossary)),
                          backgroundColor: Colors.transparent,
                          radius: 14),
                      title: Text(
                        'Glossary',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () {
                        context.read<SelectionProvider>().selectedTile = 1;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GlossaryPage()));
                      }),
                  ListTile(
                      selected: selectionProvider.selectedTile == 2,
                      selectedTileColor: selectionProvider.selectedTile == 2
                          ? (themeProvider.getTheme().brightness ==
                                  Brightness.dark
                              ? const Color.fromARGB(255, 85, 98, 105)
                              : const Color.fromARGB(255, 188, 200, 207))
                          : null,
                      leading: CircleAvatar(
                        backgroundImage: selectionProvider.selectedTile == 2
                            ? const AssetImage(MenuIcons.activeSettings)
                            : (themeProvider.getTheme().brightness ==
                                    Brightness.dark
                                ? const AssetImage(MenuIcons.darkSettings)
                                : const AssetImage(MenuIcons.settings)),
                        backgroundColor: Colors.transparent,
                        radius: 13,
                      ),
                      title: Text(
                        'Settings',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () {
                        context.read<SelectionProvider>().selectedTile = 2;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsPage()));
                      }),
                  ListTile(
                      selected: selectionProvider.selectedTile == 3,
                      selectedTileColor: selectionProvider.selectedTile == 3
                          ? (themeProvider.getTheme().brightness ==
                                  Brightness.dark
                              ? const Color.fromARGB(255, 85, 98, 105)
                              : const Color.fromARGB(255, 188, 200, 207))
                          : null,
                      leading: CircleAvatar(
                        backgroundImage: selectionProvider.selectedTile == 3
                            ? const AssetImage(MenuIcons.activeAbout)
                            : (themeProvider.getTheme().brightness ==
                                    Brightness.dark
                                ? const AssetImage(MenuIcons.darkAbout)
                                : const AssetImage(MenuIcons.about)),
                        backgroundColor: Colors.transparent,
                        radius: 13,
                      ),
                      title: Text(
                        'About',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () {
                        context.read<SelectionProvider>().selectedTile = 3;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutPage()));
                      })
                ])));
  }
}
