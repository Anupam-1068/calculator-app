import 'package:calculator_app/controllers/converter_controller.dart';
import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  final ConverterController controller;

  ConverterScreen({required this.controller});

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kilometer to Mile Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: widget.controller.model.kilometerController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Kilometers'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.controller.convertKilometersToMiles();
                });
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 16.0),
            Text('Miles: ${widget.controller.model.mileController.text}'),
          ],
        ),
      ),
    );
  }
}