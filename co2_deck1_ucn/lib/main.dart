import 'package:co2_deck1_ucn/pages/menu_drawer_pages/home_page.dart';
import 'package:co2_deck1_ucn/providers/data_access_provider.dart';
import 'package:co2_deck1_ucn/providers/selection_provider.dart';
import 'package:co2_deck1_ucn/providers/theme_provider.dart';
import 'package:co2_deck1_ucn/utils/themes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int theme = prefs.getInt('theme') ?? 0;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(theme == 0 ? lightTheme : darkTheme)),
    ChangeNotifierProvider<SelectionProvider>(
        create: (_) => SelectionProvider()),
    ChangeNotifierProvider<DataAccessProvider>(
        create: (_) => DataAccessProvider()),
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
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        home: const WindFarmProvider());
  }
}

class WindFarmProvider extends StatefulWidget {
  const WindFarmProvider({super.key});

  @override
  State<WindFarmProvider> createState() => _WindFarmProviderState();
}

class _WindFarmProviderState extends State<WindFarmProvider> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      final wfmodel = Provider.of<DataAccessProvider>(context, listen: false);
      wfmodel.getWindFarms();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
