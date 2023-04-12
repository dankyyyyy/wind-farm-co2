import 'dart:convert';
import "package:co2_deck1_ucn/models/wind_farm.dart";
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<WindFarm>?> getAllWindFarms() async {
  List<WindFarm>? result = [];
  try {
    final response = await http.get(
      Uri.parse("https://api.deck1.com/sites"),
      headers: {"x-d1-apikey": "f5Bii7gYwvDZ"},
    );
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      for (int i = 0; i < extractedData.length; i++) {
        result.add(WindFarm.fromJson(extractedData[i]));
      }
    } else {
      if (kDebugMode) {
        print("Incorrect response");
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("An error occured whiole retrieving windfarm data.");
    }
  }
  return result;

  /*String data = await rootBundle.loadString("assets/data/windfarms.json");
    final extractedData = json.decode(response.body);
    List<WindFarm> windfarms = [];
    for (int i = 0; i < extractedData.length; i++) {
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
}

Future<WindFarm?> getWindFarmById(String id) async {
  WindFarm? result;
  try {
    final response = await http.get(
      Uri.parse("https://api.deck1.com/sites/$id"),
      headers: {"x-d1-apikey": "f5Bii7gYwvDZ"},
    );
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      result = WindFarm.fromJson(extractedData);
    } else {
      if (kDebugMode) {
        print("Incorrect response");
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("An error occured while retrieving windfarm with id:$id.");
    }
  }
  return result;
}

  /* Future<void> getTotals() async {
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
    if (windFarms.isEmpty) {
      getWindFarms();
    }
    return windFarms;
  }*/