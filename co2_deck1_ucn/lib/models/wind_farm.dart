import 'package:latlong2/latlong.dart';

class WindFarm {
  String? id;
  String? location;
  String? type;
  String? owner;
  String? organisation;
  String? name;
  String? description;
  bool? isActive;
  LatLng? locationLatLng;
  String? status;

  WindFarm(
      {this.id,
      this.location,
      this.type,
      this.owner,
      this.organisation,
      this.name,
      this.description,
      this.isActive,
      this.locationLatLng,
      this.status});

  WindFarm.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    location = json['location'];
    type = json['type'];
    owner = json['owner'];
    organisation = json['organisation'];
    name = json['name'];
    description = json['description'];
    isActive = json['isActive'];
    locationLatLng = LatLng(json['centroid']?['coordinates']?[1] as double,
        json['centroid']?['coordinates']?[0] as double);
    status = json['status'];
  }

  @override
  String toString() {
    return "Windfarm(id: $id, name: $name, latlong ${locationLatLng.toString()})";
  }
}
