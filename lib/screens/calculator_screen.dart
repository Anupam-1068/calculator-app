import 'package:flutter/material.dart';
import 'history_screen.dart';
import 'package:calculator_app/controllers/calculator_controller.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorController _controller = CalculatorController();

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



class HistoryDisplay extends StatelessWidget {
  final CalculatorController controller;

  HistoryDisplay({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            controller.getDisplay(),
            style: TextStyle(fontSize: 24.0),
          ),
          FutureBuilder<double>(
            future: controller.calculateResult(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  'Calculating...',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                );
              } else if (snapshot.hasError) {
                return Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                );
              } else {
                return Text(
                  ' = ${snapshot.data}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
