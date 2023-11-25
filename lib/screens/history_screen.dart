import 'package:calculator_app/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final CalculatorController controller;

  HistoryScreen({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: FutureBuilder<List<String>>(
        future: controller.getHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<String> historyList = snapshot.data!;
            return ListView(
              children: historyList.map((item) {
                return ListTile(
                  title: Text(item),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
