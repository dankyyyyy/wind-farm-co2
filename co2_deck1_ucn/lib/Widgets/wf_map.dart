import 'package:co2_deck1_ucn/models/wind_farm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
//import 'package:flutter_map_List<WindFarm> getWindFarmsList, marker_cluster/flutter_map_marker_cluster.dart'; MUST IList<WindFarm> getWindFarmsList, MPLEMENT FOR BETTER PERFORMANCE!!

// ignore: camel_case_types
class WF_Map extends StatefulWidget {
  final List<WindFarm> windfarms;

  const WF_Map(this.windfarms, {super.key});

  @override
  State<WF_Map> createState() => _WF_MapState();
}

// ignore: camel_case_types
class _WF_MapState extends State<WF_Map> {
  List<Marker> createdMarkers = [];

  //Map widget
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          minZoom: 0.5,
          maxZoom: 18.0,
          center: LatLng(56.5, 9.5),
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          zoom: 6,
        ),
        children: [
          TileLayer(
            urlTemplate: themeProvider.getTheme().brightness == Brightness.dark
                ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
                : 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
            markers: createdMarkers,
            builder: (context, markers) {
              return Container();
            },
          )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    createMarkers();
  }

  void createMarkers() {
    List<Marker> markers = [];
    for (var wf in widget.windfarms) {
      markers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: wf.latLng,
        builder: (ctx) => Column(
          children: [
            Text(wf.name),
            IconButton(
              icon: const Icon(Icons.location_on),
              color: Colors.red,
              iconSize: 45.0,
              onPressed:
                  () {}, //I don't have the slightest idea how to call this damn method
            ),
          ],
        ),
      ));
    }
    if (kDebugMode) {
      print("markers created!");
    }
    setState(() {
      createdMarkers = markers;
    });
  }
}
