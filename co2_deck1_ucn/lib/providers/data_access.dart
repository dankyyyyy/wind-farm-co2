import 'dart:convert';

//import 'package:http/http.dart' as http;
import "package:co2_deck1_ucn/models/wind_farm.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:latlong2/latlong.dart';

class WindfarmDataAccess {
  List<WindFarm> windFarms = [];

  Future<String> getAnalyticsJSON() {
    return rootBundle.loadString("assets/data/analytics_site_daily.json");
  }

  Future<String> getWindFarmsJSON() {
    return rootBundle.loadString("assets/data/windfarms.json");
  }

  Future<void> getWindFarms() async {
    //final url = Uri.parse("https://deck1.dk/api.json");
    //final response = await http.get(url);
    String data = await getWindFarmsJSON();
    final extractedData = json.decode(data) as List<dynamic>;
    final List<WindFarm> farms = [];

    for (int i = 0; i < extractedData.length; i++) {
      //if (!farms.any((farm) => farm.id == extractedData[i]["siteId"]["\$oid"])) {
      farms.add(
        WindFarm(
          extractedData[i]?["_id"]?["\$oid"],
          extractedData[i]["name"],
          LatLng(extractedData[i]?["point"]?["coordinates"][0],
              extractedData[i]?["point"]?["coordinates"][1]),
        ),
      );
      //}
    }
    windFarms = farms;
    getTotals();
    if (kDebugMode) {
      print("farms length: ${windFarms.length.toString()}");
    }
    return;
  }

  Future<void> getTotals() async {
    String data = await getAnalyticsJSON();
    final extractedData = json.decode(data) as List<dynamic>;

    for (int i = 0; i < extractedData.length; i++) {
      DateTime dt = DateTime.parse(extractedData[i]?["date"]?["\$date"]);

      // get helicopters total
      List<dynamic> helis = extractedData[i]?["helicopters"];
      double helisTotal = 0;

      for (var h in helis) {
        helisTotal += h["totals"]["co2"];
      }

      var farmId = extractedData[i]["siteId"]["\$oid"];

      if (windFarms.where((element) => element.id == farmId).isNotEmpty) {
        windFarms.firstWhere((element) => element.id == farmId).setHelicopters =
            {dt: helisTotal};
      }

      // get vessels total
      List<dynamic> vesls = extractedData[i]?["vessels"];
      double vesselsTotal = 0;

      for (var v in vesls) {
        vesselsTotal += v["totals"]["co2"];
      }

      if (windFarms.where((element) => element.id == farmId).isNotEmpty) {
        windFarms.firstWhere((element) => element.id == farmId).setVessels = {
          dt: vesselsTotal
        };
      }
    }
    return;
  }

  List<WindFarm> get getWindFarmsList {
    return windFarms;
  }
}
