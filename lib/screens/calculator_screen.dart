import 'package:calculator_app/controllers/calculator_controller.dart';
import 'package:calculator_app/controllers/converter_controller.dart';
import 'package:calculator_app/model/converter_model.dart';
import 'package:calculator_app/screens/converter_screen.dart';
import 'package:calculator_app/screens/history_screen.dart';
import 'package:calculator_app/service/converter_service.dart';
import 'package:calculator_app/widgets/history_display.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorController _controller = CalculatorController();
  final ConverterController converterController = ConverterController(
    model: ConverterModel(),
    service: ConverterService(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
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
            icon: Icon(Icons.swap_horiz),
            onPressed: () {
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
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: HistoryDisplay(controller: _controller),
            ),
          ),
          _buildButtonRow(['7', '8', '9', '/']),
          _buildButtonRow(['4', '5', '6', '*']),
          _buildButtonRow(['1', '2', '3', '-']),
          _buildButtonRow(['0', '.', '=', '+']),
          SizedBox(height: 10.0),
          _buildClearButton(),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons.map((button) => _buildButton(button)).toList(),
      ),
    );
  }

 Widget _buildButton(String buttonText) {
  return Container(
    margin: EdgeInsets.all(10.0),
    width: 70.0,
    height: 70.0,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
      ),
      onPressed: () {
        setState(() {
          _controller.onButtonPressed(buttonText);
        });
      },
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 24.0),
      ),
    ),
  );
}


  Widget _buildClearButton() {
  return Container(
    width: 70.0,
    height: 70.0,
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
      ),
      onPressed: () {
        setState(() {
          _controller.clear();
        });
      },
      child: Text(
        'C',
        style: TextStyle(fontSize: 24.0),
      ),
    ),
  );
}
}
