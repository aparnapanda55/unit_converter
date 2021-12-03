import 'package:flutter/material.dart';
import 'convert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const inputStyle = TextStyle();

  static const labelStyle = TextStyle();

  double? _value;
  String? _fromUnit;
  String? _toUnit;
  String? _dimension;

  @override
  void initState() {
    _value = 1;
    _dimension = dimensions()[0];
    _fromUnit = units(_dimension!)[0];
    _toUnit = units(_dimension!)[1];
    super.initState();
  }

  String _result() {
    if ([_value, _fromUnit, _toUnit].every((element) => element != null)) {
      return convert(_dimension!, _value!, _fromUnit!, _toUnit!).toString();
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UnitDropdown(
                items: dimensions(),
                value: _dimension!,
                onChanged: (value) {
                  setState(() {
                    _dimension = value;
                    _fromUnit = units(_dimension!)[0];
                    _toUnit = units(_dimension!)[1];
                  });
                },
              ),
              const Text('Value', style: labelStyle),
              TextFormField(
                style: inputStyle,
                initialValue: _value.toString(),
                decoration: const InputDecoration(
                  hintText: "measure to be converted",
                ),
                onChanged: (value) {
                  setState(() {
                    _value = double.tryParse(value);
                  });
                },
              ),
              const Text('From', style: labelStyle),
              UnitDropdown(
                items: units(_dimension!),
                value: _fromUnit!,
                onChanged: (value) {
                  setState(() {
                    if (value == _toUnit) {
                      _toUnit = _fromUnit;
                    }
                    _fromUnit = value;
                  });
                },
              ),
              const Text('To', style: labelStyle),
              UnitDropdown(
                items: units(_dimension!),
                value: _toUnit!,
                onChanged: (value) {
                  setState(() {
                    if (value == _fromUnit) {
                      _fromUnit = _toUnit;
                    }
                    _toUnit = value;
                  });
                },
              ),
              Text(_result()),
            ],
          ),
        ),
      ),
    );
  }
}

class UnitDropdown extends StatelessWidget {
  const UnitDropdown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final List<String> items;
  final String value;
  final void Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: items
          .map(
            (e) => DropdownMenuItem<String>(
              child: Text(e),
              value: e,
            ),
          )
          .toList(),
      onChanged: onChanged,
      value: value,
      isExpanded: true,
    );
  }
}
