import 'package:flutter/material.dart';

import '../../utils/panel_utils.dart';

class NavBarHome extends StatelessWidget {
  NavBarHome({super.key});
  final panelUtils = PanelUtils();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        panelUtils.buildHeader(context),
        panelUtils.buildQuickDetails(),
        Text(
          "TBA: Home",
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
