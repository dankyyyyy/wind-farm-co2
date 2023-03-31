import 'package:latlong2/latlong.dart';

class WindFarm {
  final String name;
  final String id;
  final LatLng latLng;
  Map<DateTime, double>? helicoptersTotal;
  Map<DateTime, double>? vesselsTotal;

  WindFarm(this.id, this.name, this.latLng, [this.helicoptersTotal, this.vesselsTotal]);

  set setHelicopters(Map<DateTime, double> helicoptersTotal) {
    this.helicoptersTotal = helicoptersTotal;
  }

  set setVessels(Map<DateTime, double> vesselsTotal) {
    this.vesselsTotal = vesselsTotal;
  }
}
