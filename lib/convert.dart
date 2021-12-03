const units = [
  'meters',
  'kilometers',
  'grams',
  'kilograms',
  'feet',
  'miles',
  'pound',
  'ounces',
];

List<List<double>> table = [
  [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
  [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
  [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
  [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
  [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
  [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
  [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
  [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
];

double convert(double value, String from, String to) {
  int nFrom = units.indexOf(from);

  if (nFrom == -1) {
    throw Exception('unknown unit $from');
  }

  int nTo = units.indexOf(to);

  if (nTo == -1) {
    throw Exception('unknown unit $to');
  }

  var multiplier = table[nFrom][nTo];
  return value * multiplier;
}
