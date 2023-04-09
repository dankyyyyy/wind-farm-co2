import 'package:flutter/material.dart';

import '../../utils/panel_utils.dart';

class NavBarComparisons extends StatelessWidget {
  NavBarComparisons({super.key});
  final panelUtils = PanelUtils();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        panelUtils.buildHeader(context),
        const Text(
          "TBA: Comparisons",
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
