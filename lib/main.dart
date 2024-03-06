import 'package:flutter/material.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConverterPage(),
    );
  }
}

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  String _selectedInputUnit = 'Centimeters';
  String _selectedOutputUnit = 'Meters';
  double _inputValue = 0.0;
  double _outputValue = 0.0;

  Map<String, double> conversionRates = {
    'Centimeters': 0.01,
    'Meters': 1.0,
    'Kilometers': 1000.0,
    'Grams': 0.001,
    'Kilograms': 1.0,
    'Pounds': 0.453592,
  };

  void convert() {
    double? inputRate = conversionRates[_selectedInputUnit];
    double? outputRate = conversionRates[_selectedOutputUnit];
    if (inputRate != null && outputRate != null) {
      double conversionFactor = inputRate / outputRate;
      setState(() {
        _outputValue = _inputValue * conversionFactor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Value',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _inputValue = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DropdownButton<String>(
                  value: _selectedInputUnit,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedInputUnit = newValue;
                      });
                    }
                  },
                  items: conversionRates.keys.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                ),
                Text('to'),
                DropdownButton<String>(
                  value: _selectedOutputUnit,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedOutputUnit = newValue;
                      });
                    }
                  },
                  items: conversionRates.keys.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: convert,
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFdaa03DFF),
                onPrimary: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Result: $_outputValue $_selectedOutputUnit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
