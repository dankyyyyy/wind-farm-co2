import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'main.dart';

class DetailsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //This makes the corners round and friendly
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      //The Sliding Panel
      body: SlidingUpPanel(
        renderPanelSheet: false,
        panel: _slidingPanel(),
        collapsed: _slidingCollapsed(),
        body: Center(
          child: WF_Map(),
        ),
      ),
    );
  }

  //the open sliding panel
  Widget _slidingPanel() {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
          //Commented out for now as it causes a tiny shadow on the sides of the corners when panel is collapsed!
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 20.0,
          //     color: Colors.grey,
          //   ),
          //]
        ),
        child: const Center(
          child: Text("this is the open details menu"),
        ));
  }

  //the collapsed sliding panel
  Widget _slidingCollapsed() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      child: const Center(
        child: Text(
          "this is the collapsed details menu - Brief Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
