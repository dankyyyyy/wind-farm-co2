import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/wind_farm.dart';
import '../services/data_access.dart';

class DataAccessProvider extends ChangeNotifier {
  List<WindFarm>? windFarms;
  bool isLoading = false;
  final Completer _isLoadingDone = Completer();
  String _windfarmId = "";

  set selectedWindfarmId(String windfarmId) {
    _windfarmId = windfarmId;
    notifyListeners();
  }

  String get selectedWindfarmId => _windfarmId;

  getWindFarms() async {
    isLoading = true;
    windFarms = (await getAllWindFarms())!;
    if (kDebugMode) {
      print(windFarms.toString());
    }
    isLoading = false;
    _isLoadingDone.complete();
    notifyListeners();
  }

  WindFarm? getWindFarmById(String id) {
    WindFarm? result;
    if (windFarms == null) {
      getWindFarms();
    }

    if (_isLoadingDone.isCompleted) {
      for (var w in windFarms!) {
        if (w.id == id) {
          result = w;
        }
      }
    } else {
      getWindFarmById(id);
    }
    return result;
  }

  /*
  List<WindFarm> get items {
    return [..._items];
  }
  void addWindFarm(WindFarm windfarm) {
    _items.add(windfarm);
    notifyListeners();
  }
  Future<void> getWindFarms() async {
    final url = Uri.parse("https://api.deck1.com/sites");
    final response =
        await http.get(url, headers: {"x-d1-apikey": "f5Bii7gYwvDZ"});
    //String data = await rootBundle.loadString("assets/data/windfarms.json");
    final extractedData = json.decode(response.body);
    List<WindFarm> windfarms = [];
    print(extractedData);
    /*for (int i = 0; i < extractedData.length; i++) {
      //if (!farms.any((farm) => farm.id == extractedData[i]["siteId"]["\$oid"])) {
      windfarms.add(
        WindFarm(
          extractedData[i]?["_id"]?["\$oid"],
          extractedData[i]["name"],
          LatLng(extractedData[i]?["point"]?["coordinates"][0],
              extractedData[i]?["point"]?["coordinates"][1]),
        ),
      );
    }*/
    _items = windfarms;
    notifyListeners();
  }*/
}
