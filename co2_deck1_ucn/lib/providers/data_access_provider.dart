import 'dart:async';

import 'package:co2_deck1_ucn/models/wind_farm_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../models/wind_farm.dart';
import '../services/data_access.dart';

class DataAccessProvider extends ChangeNotifier {
  List<WindFarm>? windFarms;
  bool isLoading = true;
  bool isLoadingAnalytics = true;
  final Completer _isLoadingDone = Completer();
  String _windfarmId = "";

  set selectedWindfarmId(String windfarmId) {
    _windfarmId = windfarmId;
    notifyListeners();
  }

  String get selectedWindfarmId => _windfarmId;
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 8));
  DateTime _endDate = DateTime.now().subtract(const Duration(days: 1));

  WindFarm? getWindFarmById(String id) {
    return windFarms!.singleWhereOrNull((e) => e.id == id);
  }

  DateTime get startDate => _startDate;

  DateTime get endDate => _endDate;

  set startDate(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  set endDate(DateTime date) {
    _endDate = date;
    notifyListeners();
  }

  getWindFarms() async {
    windFarms = (await getAllWindFarms())!;
    isLoading = false;
    _isLoadingDone.complete();
    notifyListeners();
  }

  WindFarm? fetchWindFarmById(String id) {
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

  Future<void> getAnalytics(String id, {bool isInit = true}) async {
    if (!isInit) {
      isLoadingAnalytics = true;
      notifyListeners();
    }

    if (windFarms == null) {
      getWindFarms();
    }
    if (windFarms != null &&
        windFarms?.singleWhere((element) => element.id == id) != null) {
      var analytics = await getWindFarmAnalytics(
          id,
          DateFormat("yyyy-MM-dd").format(_startDate),
          DateFormat("yyyy-MM-dd").format(_endDate));
      List<WindFarmDailyAnalytics>? listOfAnalytics =
          windFarms?.singleWhere((element) => element.id == id).analytics;
      listOfAnalytics?.clear();
      listOfAnalytics?.addAll(analytics!);
      //if (!isInit) {
      isLoadingAnalytics = false;
      notifyListeners();
      //}
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

  void clearData() {
    _windfarmId = "";
    notifyListeners();
  }
}
