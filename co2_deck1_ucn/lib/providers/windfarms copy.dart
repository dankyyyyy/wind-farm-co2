import 'dart:async';

import 'package:co2_deck1_ucn/models/wind_farm_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../models/wind_farm.dart';
import '../services/data_access.dart';

class WindFarms extends ChangeNotifier {
  List<WindFarm>? windFarms;
  bool isLoading = false;
  final Completer _isLoadingDone = Completer();

  getWindFarms() async {
    isLoading = true;
    windFarms = (await getAllWindFarms())!;
    print(windFarms.toString());
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

  Future<List<WindFarmDailyAnalytics>?> getAnalytics(
      String id, String startDate, String endDate) async {
    isLoading = true;
    if (_isLoadingDone.isCompleted == false) {
      getAnalytics(id, startDate, endDate);
    }
    if (windFarms == null) {
      getWindFarms();
    }
    if (windFarms?.singleWhere((element) => element.id == id) != null) {
      if (windFarms
              ?.singleWhere((element) => element.id == id)
              .analytics
              ?.singleWhereOrNull((e) => e.dateString == startDate) ==
          null) {
        var analytics = await getWindFarmAnalytics(id, startDate, endDate);
       
        windFarms
              ?.singleWhere((element) => element.id == id)
              .analytics?.addAll(analytics!);

        print(
            "analytics: ${analytics == null ? "0" : analytics.length.toString()}");

        return analytics;
      }
    } else {
      getWindFarmById(id);
    }

  }

  Future<double> getYTD(String id) async {
    isLoading = true;
    if (!_isLoadingDone.isCompleted) {
      getYTD(id);
    }
    if (windFarms == null) {
      getWindFarms();
    }
    String startDate = DateFormat("yyyy-MM-dd").format(DateTime(
        DateTime.now().year - 1, DateTime.now().month, DateTime.now().day));
    String endDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    double analytics = await getYTDAnalytics(id, startDate, endDate);
    isLoading = false;
    notifyListeners();
    return analytics;
  }
}
