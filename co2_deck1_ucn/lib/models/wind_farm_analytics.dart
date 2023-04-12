class WindFarmDailyAnalytics {
  String? id;
  DateTime? date;
  late double helicoptersTotal;
  late double vesselsTotal;

  WindFarmDailyAnalytics({
    this.id,
    this.date,
    this.helicoptersTotal = 0,
    this.vesselsTotal = 0,
  });

  WindFarmDailyAnalytics.fromJson(Map<String, dynamic> json) {
    id = json['siteId'];
    date = DateTime.parse(json['date']);

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
  }
}
