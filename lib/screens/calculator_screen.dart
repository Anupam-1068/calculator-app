import 'package:calculator_app/controllers/converter_controller.dart';
import 'package:calculator_app/model/converter_model.dart';
import 'package:calculator_app/screens/converter_screen.dart';
import 'package:calculator_app/service/converter_service.dart';
import 'package:calculator_app/widgets/history_display.dart';
import 'package:flutter/material.dart';
import 'history_screen.dart';
import 'package:calculator_app/controllers/calculator_controller.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorController _controller = CalculatorController();
  final ConverterController converterController = ConverterController(model: ConverterModel(), service: ConverterService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calculator'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(controller: _controller),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.swap_horiz), // Icon for the converter screen
            onPressed: () {
              // Navigate to the converter screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConverterScreen(controller: converterController),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display area
          HistoryDisplay(controller: _controller),
          // Row of buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('0'),
              _buildButton('.'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
      // Clear button
      ElevatedButton(
        onPressed: () {
          setState(() {
            _controller.clear();
          });
        },
        child: Text(
          'C', // Clear button text
          style: TextStyle(fontSize: 20.0),
        ),
      )
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _controller.onButtonPressed(buttonText);
        });
      },
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
