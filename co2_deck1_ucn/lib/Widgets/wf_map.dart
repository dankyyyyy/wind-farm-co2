import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
//import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart'; MUST IMPLEMENT FOR BETTER PERFORMANCE!!

// ignore: camel_case_types
class WF_Map extends StatelessWidget {
  WF_Map({super.key});

  //Map widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          minZoom: 5.5,
          maxZoom: 18.0,
          center: LatLng(56.188, 11.617),
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          zoom: 10.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: markers,
          )
        ],
      ),
    );
  }

  //Windfarm Markers
  final List<Marker> markers = [
    //should it be 'final' or something else?
    Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(54.8, 13.68),
      builder: (ctx) => Column(
        children: [
          const Text('Arcadis Ost 1'),
          IconButton(
            icon: const Icon(Icons.location_on),
            color: Colors.red,
            iconSize: 45.0,
            onPressed:
                () {}, //I don't have the slightest idea how to call this damn method
          ),
        ],
      ),
    ),
  ];
}
