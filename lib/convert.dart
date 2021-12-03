const data = {
  'mass': {
    'kg': {
      'factor': 1,
    },
    'gram': {
      'factor': 0.001,
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
      : (fromFactor as double) / (toFactor as double);
}
