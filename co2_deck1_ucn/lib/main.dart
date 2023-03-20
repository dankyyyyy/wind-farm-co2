import 'dart:ui';

import 'package:co2_deck1_ucn/details_menu.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart'; MUST IMPLEMENT FOR BETTER PERFORMANCE!!

void main() => runApp(DetailsMenu());

class WF_Map extends StatelessWidget {
  //Map widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(56.188, 11.617),
          zoom: 8.0,
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
          Text('Arcadis Ost 1'),
          IconButton(
            icon: Icon(Icons.location_on),
            color: Colors.red,
            iconSize: 45.0,
            onPressed: () {
              // Show details_menu
            },
          ),
        ],
      ),
    ),
  ];
}
