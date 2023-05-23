import 'package:co2_deck1_ucn/model/wind_farm_analytics.dart';
import 'package:latlong2/latlong.dart';

class WindFarm {
  String? id;
  String? name;
  String? description;
  bool? isActive;
  LatLng? locationLatLng;
  List<WindFarmDailyAnalytics>? analytics;
  String? location;
  int? windTurbines;
  String? windTurbinesModel;
  double? power;
  String? logo;
  /* String? type;
  String? owner;
  String? organisation;
  String? status*/

  WindFarm(
      {this.id,
      this.location,
      this.name,
      this.description,
      this.isActive,
      this.locationLatLng,
      this.analytics,
      this.windTurbines,
      this.windTurbinesModel,
      this.power,
      this.logo
      /*this.type,
      this.owner,
      this.organisation,
      this.status*/
      });

  WindFarm.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    location = json['location'];
    name = json['name'];
    description = json['description'];
    isActive = json['isActive'];
    locationLatLng = LatLng(json['centroid']?['coordinates']?[1] as double,
        json['centroid']?['coordinates']?[0] as double);
    analytics = List.empty(growable: true);
    windTurbines = json['windTurbines'];
    windTurbinesModel = json['windTurbinesModel'];
    power = json['power'];
    logo = json['logo'];
    /*type = json['type'];
    owner = json['owner'];
    organisation = json['organisation'];
    status = json['status'];*/
  }

  @override
  String toString() {
    return "Windfarm(id: $id, name: $name, latlong ${locationLatLng.toString()})";
  }
}
