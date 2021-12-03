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
  double? _result;

  final List<String> _units = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pound',
    'ounces',
  ];

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
              const Text('Value', style: labelStyle),
              TextField(
                style: inputStyle,
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
              DropdownButton<String>(
                items: _units
                    .map(
                      (e) => DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _fromUnit = value;
                  });
                },
                value: _fromUnit,
                style: inputStyle,
                isExpanded: true,
              ),
              const Text('To', style: labelStyle),
              DropdownButton<String>(
                items: _units
                    .map(
                      (e) => DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _toUnit = value;
                  });
                },
                value: _toUnit,
                style: inputStyle,
                isExpanded: true,
              ),
              ElevatedButton(
                child: const Text(
                  'Convert',
                  style: inputStyle,
                ),
                onPressed: () {
                  if ([_value, _fromUnit, _toUnit].every((e) => e != null)) {
                    setState(() {
                      _result = convert(_value!, _fromUnit!, _toUnit!);
                    });
                  }
                },
              ),
              Text(_result?.toString() ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}