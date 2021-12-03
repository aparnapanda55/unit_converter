const data = {
  'mass': {
    'kilogram': {
      'factor': 1,
    },
    'gram': {
      'factor': 1000,
    },
  },
  'length': {
    'meter': {
      'factor': 1,
    },
    'kilometer': {
      'factor': 1000,
    },
    'foot': {
      'factor': 3.28084,
      'approximate': true,
    }
  }
};

List<String> dimensions() => List.unmodifiable(data.keys);

List<String> units(String dimension) =>
    List.unmodifiable((data[dimension] ?? {}).keys);

double? convert(
    String dimension, double value, String fromUnit, String toUnit) {
  final fromFactor = data[dimension]?[fromUnit]?['factor'];
  final toFactor = data[dimension]?[toUnit]?['factor'];
  return (fromFactor == null || toFactor == null)
      ? null
      : (toFactor as double) / (fromFactor as double) * value;
}
