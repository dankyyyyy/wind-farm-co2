import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widgets/system/menu_drawer.dart';
import '../utils/glossary_utils.dart';
import '../utils/size_config.dart';

class GlossaryDetails extends StatelessWidget {
  final String title;
  final glossaryUtils = GlossaryUtils();

  GlossaryDetails(this.title, {super.key});

  /*static List<String> titles = <String>[
    "Green Energy vs\n Traditional Sources",
    "Onshore vs Offshore\n Windfarms",
    "A Rundown on CO2\n Taxes",
    "Helicopters vs Vessels"
  ];*/

  @override
  Widget build(BuildContext context) {
    Future<String?> content = glossaryUtils.loadContent(title);
    List<Uri>? sources = glossaryUtils.determineSources(title);
    Uri? url1 = sources?.elementAt(0);
    Uri? url2 = sources?.elementAt(1);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Glossary'),
          leading: Builder(
            builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
        ),
        drawer: const MenuDrawer(),
        body: Column(children: [
          !title.contains("\n")
              ? const SizedBox(height: 30)
              : const SizedBox(height: 20),
          Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              )),
          !title.contains("\n")
              ? const SizedBox(height: 20)
              : const SizedBox(height: 0),
          Center(
              child: SizedBox(
            height: getProportionateScreenHeight(530),
            width: getProportionateScreenWidth(400),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.fromLTRB(12, 5, 12, 12),
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: FutureBuilder(
                    future: content,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!,
                          style: Theme.of(context).textTheme.bodyLarge,
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )),
            ),
          )),
          SizedBox(
              height: 90,
              width: getProportionateScreenWidth(400),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Find out more ",
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(
                              text: "here",
                              style: Theme.of(context).textTheme.labelLarge,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(url1!);
                                }),
                          TextSpan(
                            text: " and ",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextSpan(
                              text: "here",
                              style: Theme.of(context).textTheme.labelLarge,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(url2!);
                                }),
                          TextSpan(
                            text: ".",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ]),
                  ),
                ),
              ))
        ]));
  }
}
