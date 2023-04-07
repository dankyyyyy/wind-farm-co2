import 'package:co2_deck1_ucn/pages/home_page.dart';
import 'package:co2_deck1_ucn/providers/selected_tile_provider.dart';
import 'package:co2_deck1_ucn/providers/theme_provider.dart';
import 'package:co2_deck1_ucn/utils/themes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int theme = prefs.getInt('theme') ?? 0;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(theme == 0 ? lightTheme : darkTheme)),
    ChangeNotifierProvider<SelectedTile>(create: (_) => SelectedTile()),
  ], child: const Program()));
}

class Program extends StatelessWidget {
  const Program({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
        title: 'DECK1 CO2',
        theme: themeProvider.getTheme(),
        home: const HomePage());
  }
}
