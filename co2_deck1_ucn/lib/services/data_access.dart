import 'dart:async';
import 'dart:convert';
import 'package:co2_deck1_ucn/exceptions/data_access_exception_messages.dart';
import 'package:co2_deck1_ucn/exceptions/retrieval_exception.dart';
import "package:co2_deck1_ucn/models/wind_farm.dart";
import 'package:co2_deck1_ucn/models/wind_farm_analytics.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../utils/api_connection_utils.dart';

// ERROR INTERCEPTION AND HANDLING

// DATA ACCESS AND HANDLING

Future<List<WindFarm>?> getAllWindFarms() async {
  List<WindFarm>? result = [];
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {apikeyname: apikey},
    );
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);

      final jsonString =
          await rootBundle.loadString('assets/data/windfarm_data.json');
      final List<dynamic> decodedJson = json.decode(jsonString);

      for (int i = 0; i < (decodedJson.length); i++) {
        if (i < extractedData.length) {
          final apiData = WindFarm.fromJson(extractedData[i]);
          final jsonData = WindFarm.fromJson(decodedJson[i]);

          apiData.id ??= jsonData.id;
          apiData.location ??= jsonData.location;
          apiData.name ??= jsonData.name;
          apiData.description = jsonData.description;
          apiData.isActive ??= jsonData.isActive;
          apiData.locationLatLng ??= jsonData.locationLatLng;
          apiData.analytics ??= jsonData.analytics;
          apiData.windTurbines ??= jsonData.windTurbines;
          apiData.windTurbinesModel ??= jsonData.windTurbinesModel;
          apiData.power ??= jsonData.power;
          apiData.logo = jsonData.logo;

          result.add(apiData);
        } else if (i >= extractedData.length && i < decodedJson.length) {
          final jsonData = WindFarm.fromJson(decodedJson[i]);
          result.add(jsonData);
        }
      }
    } else {
      print(
          "${DataAccessExceptionMessages.CouldNotRetrieveWFs} Status: ${response.statusCode} ${response.reasonPhrase}");
    }
  } catch (e) {
    throw RetreivalFailedException(
        DataAccessExceptionMessages.CouldNotRetrieveWFs);
  }
  return result;
}

Future<WindFarm?> getWindFarmById(String id) async {
  WindFarm? result;
  try {
    final response = await http.get(
      Uri.parse("$url/$id"),
      headers: {apikeyname: apikey},
    );
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      final apiData = WindFarm.fromJson(extractedData);

      // Fetch data from JSON file
      final jsonString =
          await rootBundle.loadString('assets/data/windfarm_data.json');
      final jsonToDecode = json.decode(jsonString);
      final jsonData = WindFarm.fromJson(jsonToDecode);

      // Merge data, giving priority to API data + JSON as back-up
      apiData.id ??= jsonData.id;
      apiData.location ??= jsonData.location;
      apiData.name ??= jsonData.name;
      apiData.description = jsonData.description;
      apiData.isActive ??= jsonData.isActive;
      apiData.locationLatLng ??= jsonData.locationLatLng;
      apiData.analytics ??= jsonData.analytics;
      apiData.windTurbines ??= jsonData.windTurbines;
      apiData.windTurbinesModel ??= jsonData.windTurbinesModel;
      apiData.power ??= jsonData.power;
      apiData.logo = jsonData.logo;

      result = apiData;
    } else {
      print(
          "Incorrect response. Status: ${response.statusCode} ${response.reasonPhrase}");
    }
  } catch (e) {
    print("An error occurred while retrieving windfarm with id:$id.");
  }
  return result;
}

Future<List<WindFarmDailyAnalytics>?> getWindFarmAnalytics(
    String id, String startDate, String endDate) async {
  List<WindFarmDailyAnalytics>? result = [];

  try {
    final response = await http.get(
      Uri.parse(
          "$analyticsurl/$id?startDate=$startDate&endDate=$endDate&includeMeasurements=false"),
      headers: {apikeyname: apikey},
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
