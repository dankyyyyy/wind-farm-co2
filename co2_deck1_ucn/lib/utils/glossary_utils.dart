import 'package:flutter/services.dart';

class GlossaryUtils {
  String? determineContent(String title) {
    if (title.contains("Green Energy")) {
      String content = "assets/data/glossary_texts/green_traditional.txt";
      return content;
    } else if (title.contains("Onshore")) {
      String content = "assets/data/glossary_texts/onshore_offshore.txt";
      return content;
    } else if (title.contains("Rundown")) {
      String content = "assets/data/glossary_texts/taxes.txt";
      return content;
    } else if (title.contains("Helicopters")) {
      String content = "assets/data/glossary_texts/helicopters_vessels.txt";
      return content;
    }
    return null;
  }

  List<Uri>? determineSources(String title) {
    if (title.contains("Green Energy")) {
      List<Uri> sources = [
        Uri.https(
            'un.org', '/en/climatechange/raising-ambition/renewable-energy'),
        Uri.https(
            'sciencedirect.com', '/science/article/pii/S1364032121007577'),
      ];
      return sources;
    } else if (title.contains("Onshore")) {
      List<Uri> sources = [
        Uri.https('energy.ec.europa.eu',
            '/topics/renewable-energy/offshore-renewable-energy_en'),
        Uri.https('guidetoanoffshorewindfarm.com', '/wind-farm-costs'),
      ];
      return sources;
    } else if (title.contains("Rundown")) {
      List<Uri> sources = [
        Uri.https('climate.ec.europa.eu',
            '/eu-action/eu-emissions-trading-system-eu-ets_en'),
        Uri.https('energy.ec.europa.eu', '/topics/energy-strategy_en'),
      ];
      return sources;
    } else if (title.contains("Helicopters")) {
      List<Uri> sources = [
        Uri.https('pes.eu.com',
            '/exclusive-article/deck1-which-is-greener-the-helicopter-or-hybrid-vessels'),
        Uri.https(
            'imo.org', '/en/MediaCentre/HotTopics/Pages/EEXI-CII-FAQ.aspx')
      ];
      return sources;
    }
    return null;
  }

  Future<String?> loadContent(String title) async {
    if (title.contains("Green Energy")) {
      final content = await rootBundle
          .loadString('assets/data/glossary_texts/green_traditional.txt');
      return content;
    } else if (title.contains("Onshore")) {
      final content = await rootBundle
          .loadString('assets/data/glossary_texts/onshore_offshore.txt');
      return content;
    } else if (title.contains("Rundown")) {
      final content =
          await rootBundle.loadString('assets/data/glossary_texts/taxes.txt');
      return content;
    } else if (title.contains("Helicopters")) {
      final content = await rootBundle
          .loadString('assets/data/glossary_texts/helicopters_vessels.txt');
      return content;
    }
    return null;
  }
}
