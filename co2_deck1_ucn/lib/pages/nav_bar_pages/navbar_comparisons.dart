import 'package:co2_deck1_ucn/Widgets/charts/comparison_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import '../../exceptions/size_config.dart';
import '../../providers/data_access_provider.dart';
import '../../utils/comparison_calculations.dart';
import '../../utils/panel_utils.dart';

class NavBarComparisons extends StatefulWidget {
  const NavBarComparisons({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBarComparisons> createState() => NavBarComparisonsState();
}

class NavBarComparisonsState extends State<NavBarComparisons> {
  DateTime _pickedDate = DateTime.now().subtract(const Duration(days: 1));
  late final DataAccessProvider windfarmData;
  @override
  void initState() {
    super.initState();
    DataAccessProvider tempWindfarmData =
        Provider.of<DataAccessProvider>(context, listen: false);
    if (tempWindfarmData.selectedWindfarmId.isNotEmpty) {
      tempWindfarmData.getAnalytics(tempWindfarmData.selectedWindfarmId);
    }
  }

  final panelUtils = PanelUtils();
  final calculations = Calculations();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                  ))
            ]);
      } else {
        return Column(children: [
          panelUtils.buildHeader(
            context,
            snapshot.getWindFarmById(snapshot.selectedWindfarmId),
          ),
          Expanded(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
                    child: Column(children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "CO₂ emissions comparison",
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(height: 18),
                      Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          margin: const EdgeInsets.fromLTRB(12, 5, 12, 10),
                          color: Colors.grey[400],
                          child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: _monthBack,
                                      child: const Icon(Icons.arrow_back_ios,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                        onTap: _showDatePicker,
                                        child: Text(
                                          DateFormat("MMMM yyyy")
                                              .format(_pickedDate),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: _monthForward,
                                      child: const Icon(Icons.arrow_forward_ios,
                                          color: Colors.black),
                                    )
                                  ]))),
                      const SizedBox(height: 10),
                      AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            height: 400,
                            child: snapshot.isLoading
                                ? const CircularProgressIndicator()
                                : ComparisonChart(
                                    snapshot.getWindFarmById(
                                        snapshot.selectedWindfarmId),
                                    snapshot.startDate,
                                    snapshot.endDate),
                          )),
                      const SizedBox(height: 18),
                      buildLegend(),
                    ]))),
            Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 15, 15, 15),
                    child: Row(children: [
                      const Icon(Icons.info_outline),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: RichText(
                              text: TextSpan(children: [
                        TextSpan(
                          text:
                              "This chart depicts the CO₂ emissions in metric tons, which would get produced if these different sources generated the same amount of energy as the wind farm.",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextSpan(
                            text: "\n\nThe total energy here is ",
                            style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(
                            // ignore: unnecessary_string_interpolations
                            text: "${totalEnergy()}",
                            style: Theme.of(context).textTheme.labelSmall),
                        TextSpan(
                            text: " generated in ",
                            style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(
                            text: "${daysBetween()}",
                            style: Theme.of(context).textTheme.labelSmall),
                        TextSpan(
                            text: " days.",
                            style: Theme.of(context).textTheme.bodySmall)
                      ])))
                    ]))),
            Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 15, 15, 15),
                    child: Column(children: [
                      Text(
                        "With this amount of energy, you could:",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 20),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),
                            const Icon(Icons.circle, size: 10),
                            const SizedBox(width: 10),
                            Expanded(
                                child: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text:
                                            "If driving an electric car using wind energy, cover a distance of approximately ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      TextSpan(
                                        text: "${electricDistance()}km",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      TextSpan(
                                        text: " , which is equivalent to ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      TextSpan(
                                        text: electricAroundGlobe(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      TextSpan(
                                        text:
                                            " trips around the earth.\nThis would emit no additional CO₂.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ])))
                          ]),
                      const SizedBox(height: 20),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),
                            const Icon(Icons.circle, size: 10),
                            const SizedBox(width: 10),
                            Expanded(
                                child: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text:
                                            "If driving a diesel car, cover a distance of approximately ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      TextSpan(
                                        text: "${dieselDistance()}km",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      TextSpan(
                                        text: " , which is equivalent to ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      TextSpan(
                                        text: dieselAroundGlobe(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      TextSpan(
                                        text:
                                            " trips around the earth. The combustion of fuel would emit ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      TextSpan(
                                        text: dieselAroundGlobeEmissions(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      TextSpan(
                                        text: " additional tons of CO₂.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ])))
                          ]),
                    ]))),
            Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 15, 15, 15),
                    child: Row(children: [
                      const Icon(Icons.info_outline),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text(
                        "Please note that these results are approximations based on information obtained from publicly accessible sources.",
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ))
                    ])))
          ]))
        ]);
      }
    });
  }

  /* Additional Methods */

  Widget buildLegend() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(children: [
          const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 237, 23, 44),
            radius: 8.0,
          ),
          const SizedBox(width: 8),
          Text('Coal plant', style: Theme.of(context).textTheme.bodySmall),
        ]),
        Row(children: [
          const CircleAvatar(
            backgroundColor: Color.fromRGBO(62, 201, 247, 1),
            radius: 8.0,
          ),
          const SizedBox(width: 8),
          Text('LNG plant', style: Theme.of(context).textTheme.bodySmall),
        ]),
        Row(children: [
          const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 43, 230, 43),
            radius: 8.0,
          ),
          const SizedBox(width: 8),
          Text(
            'Wind farm',
            style: Theme.of(context).textTheme.bodySmall,
          )
        ])
      ]);

  /* Date Picker Methods */

  void _showDatePicker() {
    showMonthYearPicker(
      context: context,
      initialDate: _pickedDate,
      firstDate: DateTime(2022, 5),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      DataAccessProvider windfarmData =
          Provider.of<DataAccessProvider>(context, listen: false);
      windfarmData.startDate = pickedDate.subtract(const Duration(days: 7));
      windfarmData.endDate = pickedDate;
      windfarmData.getAnalytics(windfarmData.selectedWindfarmId, isInit: false);

      setState(() {
        _pickedDate = pickedDate;
      });
    });
  }

  void _monthForward() {
    if (_pickedDate
        .isBefore(DateTime(DateTime.now().year, DateTime.now().month))) {
      DateTime startDate = DateTime(
          _pickedDate.month == 12 ? _pickedDate.year + 1 : _pickedDate.year,
          _pickedDate.month == 12 ? 1 : _pickedDate.month + 1,
          1);
      updateProvider(
          startDate,
          DateTime(startDate.year, startDate.month,
              DateUtils.getDaysInMonth(startDate.year, startDate.month)));
      setState(() {
        _pickedDate = startDate;
      });
    }
  }

  void _monthBack() {
    if (_pickedDate.isAfter(DateTime(2022, 4))) {
      DateTime startDate = DateTime(
          _pickedDate.month == 1 ? _pickedDate.year - 1 : _pickedDate.year,
          _pickedDate.month == 1 ? 12 : _pickedDate.month - 1,
          1);
      updateProvider(
          startDate,
          DateTime(startDate.year, startDate.month,
              DateUtils.getDaysInMonth(startDate.year, startDate.month)));
      setState(() {
        _pickedDate = startDate;
      });
    }
  }

  updateProvider(DateTime startDate, DateTime endDate) {
    DataAccessProvider windFarmProvider =
        Provider.of<DataAccessProvider>(context, listen: false);
    windFarmProvider.startDate = startDate;
    windFarmProvider.endDate = endDate;
    windFarmProvider.getAnalytics(windFarmProvider.selectedWindfarmId,
        isInit: false);
  }

  int daysBetween() {
    final dataAccessProvider =
        Provider.of<DataAccessProvider>(context, listen: false);
    DateTime startDate = dataAccessProvider.startDate;
    DateTime endDate = dataAccessProvider.endDate;
    int days = endDate.difference(startDate).inDays;
    return days;
  }

  /* Comparison Calculation Text-Outs */

  double totalEnergyCalc() {
    final dataAccessProvider =
        Provider.of<DataAccessProvider>(context, listen: false);
    double totalEnergy;
    int? turbines = dataAccessProvider
        .getWindFarmById(dataAccessProvider.selectedWindfarmId)
        ?.windTurbines;
    double? capacity = dataAccessProvider
        .getWindFarmById(dataAccessProvider.selectedWindfarmId)
        ?.power;
    totalEnergy = calculations.calculateEnergyInDays(
        daysBetween(), turbines!, capacity!, calculations.expectation);
    return totalEnergy;
  }

  String totalEnergy() {
    String result;
    double totalEnergy = totalEnergyCalc();

    if (daysBetween() >= 7) {
      result = "${(totalEnergy / 1000).round()}GWh";
    } else {
      result = "${totalEnergy.round()}MWh";
    }
    return result;
  }

  String electricDistance() {
    final formatter = NumberFormat('#,##0', 'en_US');
    int unformattedDistance = wfMwhCarInKm(totalEnergyCalc()).round();
    String distance = formatter.format(unformattedDistance).toString();
    return distance;
  }

  String dieselDistance() {
    final formatter = NumberFormat('#,##0', 'en_US');
    int unformattedDistance = coalMwhCarInKm(totalEnergyCalc()).round();
    String distance = formatter.format(unformattedDistance).toString();
    return distance;
  }

  String electricAroundGlobe() {
    String times = electricTimesAroundGlobe(totalEnergyCalc()).toString();
    return times;
  }

  String dieselAroundGlobe() {
    String times = dieselTimesAroundGlobe(totalEnergyCalc()).toString();
    return times;
  }

  String dieselAroundGlobeEmissions() {
    String tons = dieselAroundGlobeInTons(totalEnergyCalc()).toString();
    return tons;
  }
}
