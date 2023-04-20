import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/data_access_provider.dart';
import '../../utils/panel_utils.dart';

class NavBarAbout extends StatefulWidget {
  const NavBarAbout({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBarAbout> createState() => NavBarAboutState();
}

class NavBarAboutState extends State<NavBarAbout> {
  final panelUtils = PanelUtils();

  @override
  Widget build(BuildContext context) {
    return Consumer<DataAccessProvider>(builder: (context, snapshot, child) {
      if (snapshot.selectedWindfarmId.isEmpty) {
        return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Text(
                  "No windfarm selected",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ]);
      } else {
        final String? description =
            snapshot.getWindFarmById(snapshot.selectedWindfarmId)?.description;
        final String? logoPath =
            snapshot.getWindFarmById(snapshot.selectedWindfarmId)?.logo;

        return ListView(padding: EdgeInsets.zero, children: <Widget>[
          panelUtils.buildHeader(
              context, snapshot.getWindFarmById(snapshot.selectedWindfarmId)),
          Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 30, 25),
              child: Column(children: [
                Image(image: AssetImage(logoPath!)),
                const SizedBox(height: 20),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Flexible(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 15, 20),
                    child: Text(
                      description!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )),
                ),
              ])),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            margin: const EdgeInsets.fromLTRB(100, 85, 100, 0),
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
            alignment: Alignment.center,
          )
        ]);
      }
    });
  }
}
