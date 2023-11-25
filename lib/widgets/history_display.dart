import 'package:calculator_app/controllers/calculator_controller.dart';
import 'package:flutter/cupertino.dart';

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