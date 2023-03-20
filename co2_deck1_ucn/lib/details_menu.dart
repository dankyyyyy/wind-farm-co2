import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'main.dart';

class DetailsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //This makes the corners round and friendly
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return MaterialApp(
      home: Scaffold(
        //The Sliding Panel
        body: SlidingUpPanel(
          panel: Center(
            child: Text("this is the sliding widget"),
          ),
          //The Collapsed Widget
          collapsed: Container(
            color: Colors.grey,
            child: Text("this is the collapsed widget"),
          ),
          //The Widget behind the Panel, in our case - The Map
          body: Center(
            child: WF_Map(),
          ),
        ),
      ),
    );
  }
}
