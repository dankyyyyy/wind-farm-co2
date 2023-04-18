// ignore_for_file: constant_identifier_names

class DataAccessExceptionMessages {
  static const String CouldNotRetrieveWFs =
      "There was a problem retrieving the windfarms."; //should cover errors when trying to load WF onto the map (and in general)

  static const String CouldNotRetrieveStatistics =
      "There was a problem retrieving the statistics for this windfarm."; //should cover panel data supplied by the API

  static const String CouldNotRetrieveDetails =
      "There was a problem retrieving the details for this windfarm."; //should cover panel data supplied by our JSON files
}
