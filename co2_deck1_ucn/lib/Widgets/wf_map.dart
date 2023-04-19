import 'package:co2_deck1_ucn/models/wind_farm.dart';
import 'package:co2_deck1_ucn/providers/data_access_provider.dart';
import 'package:co2_deck1_ucn/resources/menu_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../Pages/nav_bar_pages/navbar_home.dart';
import '../providers/theme_provider.dart';

// ignore: camel_case_types
class WindFarmMap extends StatefulWidget {
  final Function(String) onWindFarmSelected;
  const WindFarmMap({super.key, required this.onWindFarmSelected});

  @override
  State<WindFarmMap> createState() => _WindFarmMapState();
}

// ignore: camel_case_types
class _WindFarmMapState extends State<WindFarmMap> {
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
              interactiveFlags:
                  InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              zoom: 6,
            ),
            children: [
          TileLayer(
            urlTemplate: themeProvider.getTheme().brightness == Brightness.dark
                ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
                : 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          Consumer<DataAccessProvider>(
              builder: (context, windfarm, child) => MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                      maxClusterRadius: 120,
                      disableClusteringAtZoom: 8,
                      fitBoundsOptions: const FitBoundsOptions(
                        padding: EdgeInsets.all(50),
                      ),
                      markers: createMarkers(windfarm.windFarms),
                      polygonOptions: const PolygonOptions(
                          isDotted: true,
                          borderColor: Colors.blueAccent,
                          color: Colors.black12,
                          borderStrokeWidth: 3),
                      builder: (context, markers) {
                        return FloatingActionButton(
                          onPressed: null,
                          child: Text(markers.length.toString()),
                        );
                      })))
        ]));
  }

  List<Marker> createMarkers(List<WindFarm>? windfarms) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final dataAccessProvider =
        Provider.of<DataAccessProvider>(context, listen: false);
    List<Marker> markers = [];

    if (windfarms != null) {
      for (var wf in windfarms) {
        markers.add(Marker(
            width: 90.0.w,
            height: 90.0.h,
            point: wf.locationLatLng!,
            builder: (ctx) => GestureDetector(
                onTap: () => onMarkerPressed(wf.id!),
                child: Column(
                  children: [
                    Image(
                      width: 25.0.w,
                      height: 35.0.h,
                      image: wf.id == dataAccessProvider.selectedWindfarmId
                          ? const AssetImage(MenuIcons.activeMapMarker)
                          : (themeProvider.getTheme().brightness ==
                                  Brightness.dark
                              ? const AssetImage(MenuIcons.darkMapMarker)
                              : const AssetImage(MenuIcons.mapMarker)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      wf.name!.replaceAll(' ', '\n'),
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    )
                  ],
                ))));
      }
    }
    return markers;
  }

  void onMarkerPressed(String windfarmId) {
    widget.onWindFarmSelected(windfarmId);
    const NavBarHome();
  }
}
