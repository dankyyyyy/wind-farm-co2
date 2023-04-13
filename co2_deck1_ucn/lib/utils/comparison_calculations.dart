class Calculations {
  // values set for AO1 as of now
  int turbines = 27; // WTG (Wind Turbine Generator)
  double capacity = 9.5; // MH/WTG (MegaHenry per WTG)
  double expectation = 0.65; // in percent, out of maximum production
  static double replacementLNG = 0.407; // T of CO2 emitted per hour
  static double replacementCoal = 0.96; // T of CO2 emitted per hour
  double helicopters = 50; //metric tons of CO2 from the api, dummy data
  double vessels = 0; //metric tons of CO2, api, dummy data

  double calculateEnergyInDays(
      int days, int turbines, double capacity, double expectation) {
    int hours = days * 24;
    double installedCapacity = turbines * capacity; //MW
    double energyInDays = installedCapacity * hours * expectation;
    return energyInDays; //MWhours
  }

  double co2EmittedLNG(int days) {
    double energyInDays = calculateEnergyInDays(days, 27, 9.5, 0.65);
    double co2LNG = energyInDays * replacementLNG;
    return co2LNG; //metric tons of CO2
  }

  double co2EmittedCoal(int days) {
    double energyInDays = calculateEnergyInDays(days, 27, 9.5, 0.65);
    double co2COAL = energyInDays * replacementCoal;
    return co2COAL; //metric tons of CO2
  }

  double co2EmittedWindFarm(double helicopters,
      double vessels) //per the same time period from the api
  {
    double co2WF = helicopters + vessels;
    return co2WF;
  }
}
