class WindFarmDailyAnalytics {
  String? id;
  DateTime? date;
  String? dateString;
  late double helicoptersTotal;
  late double vesselsTotal;
  bool empty = false;

  WindFarmDailyAnalytics(
      {this.id,
      this.date,
      this.dateString,
      this.helicoptersTotal = 0,
      this.vesselsTotal = 0,
      this.empty = false});

  WindFarmDailyAnalytics.fromJson(Map<String, dynamic> json) {
    id = json['siteId'];
    date = DateTime.parse(json['date']);
    dateString = json['date'].toString().substring(0, 10);

    helicoptersTotal = 0;
    if (json['helicopters'] != null) {
      json['helicopters'].forEach((h) {
        helicoptersTotal += h["totals"]["co2"];
      });
    }
    vesselsTotal = 0;
    if (json['vessels'] != null) {
      json['vessels'].forEach((v) {
        vesselsTotal += v["totals"]["co2"];
      });
    }

    if (json['helicopters'] == null && json['vessels'] == null) {
      empty = true;
    }
  }

  @override
  String toString() {
    return "$dateString: $helicoptersTotal, $vesselsTotal";
  }
}
