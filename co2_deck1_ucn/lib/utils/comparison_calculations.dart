class Calculations {
  // values set for AO1 as of now
  int turbines = 27; // WTG (Wind Turbine Generator)
  double capacity = 9.5; // MH/WTG (MegaHenry per WTG)
  double expectation = 0.65; // in percent, out of maximum production
  static double replacementLNG = 0.407; // T of CO2 emitted per hour
  static double replacementCoal = 0.96; // T of CO2 emitted per hour
  double helicopters = 50; //metric tons of CO2 from the api, dummy data
  double vessels = 0; //metric tons of CO2, api, dummy data

  //energy produced just by windfarm
  double calculateEnergyInDays(
      int days, int turbines, double capacity, double expectation) {
    int hours = days * 24;
    double idealProduction = turbines * capacity; //MW
    double energyInDays = idealProduction * hours * expectation;
    return energyInDays; //MWhours
  }

  //emissions from windfarm with replacement LNG energy (35% of the time)
  double replacementEmissionsLNG(
      int days, int turbines, double capacity, double expectation) {
    int hours = days * 24;
    double replacementEmissions =
        (turbines * capacity * hours) * ((1 - expectation) * replacementLNG);
    return replacementEmissions;
  }

  //emissions from windfarm with replacement coal energy (35% of the time)
  double replacementEmissionsCoal(
      int days, int turbines, double capacity, double expectation) {
    int hours = days * 24;
    double replacementEmissions =
        (turbines * capacity * hours) * ((1 - expectation) * replacementCoal);
    return replacementEmissions;
  }

  //LNG emissions per equivalent energy produced by WindFarm
  double co2EmittedLNG(
      int days, int turbines, double capacity, double expectation) {
    double energyInDays =
        calculateEnergyInDays(days, turbines, capacity, expectation);
    double co2LNG = energyInDays * replacementLNG;
    return co2LNG; //metric tons of CO2
  }

  double co2EmittedCoal(
      int days, int turbines, double capacity, double expectation) {
    double energyInDays =
        calculateEnergyInDays(days, turbines, capacity, expectation);
    double co2COAL = energyInDays * replacementCoal;
    return co2COAL; //metric tons of CO2
  }

  double co2EmittedTransport(double helicopters,
      double vessels) //per the same time period from the api
  {
    double transport = helicopters + vessels;
    return transport;
  }

  double totalEmissionsCoal(int days, int turbines, double capacity,
      double expectation, double helicopters, double vessels) {
    double coalEmissions =
        replacementEmissionsCoal(days, turbines, capacity, expectation);
    double transportEmissions = co2EmittedTransport(helicopters, vessels);
    double totalEmissionsC = coalEmissions + transportEmissions;
    return totalEmissionsC;
  }

  double totalEmissionsLNG(int days, int turbines, double capacity,
      double expectation, double helicopters, double vessels) {
    double lngEmissions =
        replacementEmissionsLNG(days, turbines, capacity, expectation);
    double transportEmissions = co2EmittedTransport(helicopters, vessels);
    double totalEmissions = lngEmissions + transportEmissions;
    return totalEmissions;
  }
}
