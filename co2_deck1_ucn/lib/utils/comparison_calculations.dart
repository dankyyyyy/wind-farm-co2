class Calculations {
  // values set for AO1 as of now
  int turbines = 27; // WTG (Wind Turbine Generator)
  double capacity = 9.5; // MH/WTG (MegaHenry per WTG)
  double expectation = 0.65; // in percent, out of maximum production
  static double lngPerHour = 0.407; // T of CO2 emitted per hour
  static double coalPerHour = 0.96; // T of CO2 emitted per hour
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

  double calculateIdealEnergy(int days, int turbines, double capacity) {
    int hours = days * 24;
    double idealProduction = turbines * capacity * hours;
    return idealProduction;
  }

  //emissions from windfarm with replacement LNG energy (35% of the time)
  double replacementEmissionsLNG(
      int days, int turbines, double capacity, double expectation) {
    int hours = days * 24;
    double replacementEmissions =
        (turbines * capacity * hours) * ((1 - expectation) * lngPerHour);
    return replacementEmissions;
  }

  //emissions from windfarm with replacement coal energy (35% of the time)
  double replacementEmissionsCoal(
      int days, int turbines, double capacity, double expectation) {
    int hours = days * 24;
    double replacementEmissions =
        (turbines * capacity * hours) * ((1 - expectation) * coalPerHour);
    return replacementEmissions;
  }

  //LNG emissions per equivalent energy produced by WindFarm
  double co2EmittedLNG(int days, int turbines, double capacity) {
    double energyInDays = calculateIdealEnergy(days, turbines, capacity);
    double co2LNG = energyInDays * lngPerHour;
    return co2LNG; //metric tons of CO2
  }

  double co2EmittedCoal(int days, int turbines, double capacity) {
    double energyInDays = calculateIdealEnergy(days, turbines, capacity);
    double co2COAL = energyInDays * coalPerHour;
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

/////////////////////////////////////////////////////////////////////

int wfMWhHome =
    3; // months 1 MWh of energy from a windfarm can supply a single family home for
double coalMWhHome = wfMWhHome /
    2; // months of time 1MWh of energy from a coal plant can supply a single family home for
int wfMWhCar =
    3500; // km 1 MWh of energy from a wind farm can be driven with in a Tesla Model S
double coalMWhCar = wfMWhCar /
    100; // km 1 MWh of energy from a coal plant can be driven with in a diesel car

int earthCircumference = 40075; //km
int engineEfficiency = 17; // km/l
double dieselEmissionsPerLiter = 0.00268; // t of CO2/l

double coalMwhCarInKm(double totalEnergy) {
  double distance = (totalEnergy * coalMWhCar);
  return distance;
}

double wfMwhCarInKm(double totalEnergy) {
  double distance = (totalEnergy * wfMWhCar);
  return distance;
}

int dieselAroundGlobeInTons(double totalEnergy) {
  int emissions = (dieselTimesAroundGlobe(totalEnergy) *
          ((earthCircumference / engineEfficiency) * dieselEmissionsPerLiter))
      .round();
  return emissions;
}

int dieselTimesAroundGlobe(double totalEnergy) {
  int times = ((coalMwhCarInKm(totalEnergy)) / earthCircumference).round();
  return times;
}

int electricTimesAroundGlobe(double totalEnergy) {
  int times = ((wfMwhCarInKm(totalEnergy)) / earthCircumference).round();
  return times;
}
