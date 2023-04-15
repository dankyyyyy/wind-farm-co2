import 'dart:convert';
import "package:co2_deck1_ucn/models/wind_farm.dart";
import 'package:co2_deck1_ucn/models/wind_farm_analytics.dart';
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
      print(
          "Incorrect response. Status: ${response.statusCode} ${response.reasonPhrase}");
    }
  } catch (e) {
    print("An error occured whiole retrieving windfarm data.");
  }
  return result;
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
      print(
          "Incorrect response. Status: ${response.statusCode} ${response.reasonPhrase}");
    }
  } catch (e) {
    print("An error occured while retrieving windfarm with id:$id.");
  }
  return result;
}

Future<List<WindFarmDailyAnalytics>?> getWindFarmAnalytics(
    String id, String startDate, String endDate) async {
  List<WindFarmDailyAnalytics>? result = [];

  try {
    final response = await http.get(
      Uri.parse(
          "https://api.deck1.com/analytics/site/$id?startDate=$startDate&endDate=$endDate&includeMeasurements=false"),
      headers: {"x-d1-apikey": "f5Bii7gYwvDZ"},
    );
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      if (extractedData.length == 0) {
        /* result.add(WindFarmDailyAnalytics.fromJson(
            <String, dynamic>{"siteId": id, "date": startDate}));*/
      } else {
        for (int i = 0; i < extractedData.length; i++) {
          result.add(WindFarmDailyAnalytics.fromJson(extractedData[i]));
          print(extractedData[i].toString());
        }
      }
    } else {
      print(
          "Incorrect response. Status: ${response.statusCode} ${response.reasonPhrase}");
    }
  } catch (e) {
    print("An error occurred while retrieving windfarm with id: $id.");
  }
  return result;
}

Future<double> getYTDAnalytics(
    String id, String startDate, String endDate) async {
  double result = 0;
  try {
    await getWindFarmAnalytics(id, startDate, endDate)
        .then((value) => value?.forEach((element) {
              result += element.helicoptersTotal + element.vesselsTotal;
            }));
  } catch (e) {
    print('An error occurred while retrieving YTD wind farm analytics: $e');
  }
  return result;
}
