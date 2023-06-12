// ignore_for_file: constant_identifier_names

class GeneralExceptionMessages {
  static const String CouldNotLoadMap =
      "There was a problem loading the map."; //should trigger if the tile provider is unavailable

  static const String CouldNotConnect =
      "Couldn't connect to the server. Please check your connection."; //should trigger if the device is offline

  static const String UnexpectedError =
      "Whoa, we didn't expect that! Please report this to us so we can improve the app!"; //for anything and everything we didn't account for!
}
