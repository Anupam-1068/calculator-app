import 'package:calculator_app/persistence/history_persistence.dart';
import 'package:calculator_app/service/calculator_service.dart';

class CalculatorController {
  final CalculatorService _calculatorService = CalculatorService();
  final HistoryPersistence _historyPersistence = HistoryPersistence();
  String _display = '';

  // Method to handle button presses
 void onButtonPressed(String buttonText) {
  _calculatorService.updateInput(buttonText);
  _display = _calculatorService.getCalculationString();
  // You can update the UI or perform additional logic here
}


  // Method to handle the equals button
  Future<void> onEqualsPressed() async {
    double result = _calculatorService.calculate();
    String calculationString = _calculatorService.getCalculationString();

    // Save to Firestore
    await _historyPersistence.addToHistory(calculationString);
    _calculatorService.clear();
  }

  // Method to get the calculation history
  Future<List<String>> getHistory() async {
    List<String> historyList = await _historyPersistence.getHistory();
    return historyList;
  }

  String getDisplay() {
    return _display;
  }

  void clear() {
    _calculatorService.clear();
  }

   // Method to calculate and return the result
  Future<double> calculateResult() async {
    double result = _calculatorService.calculate();
    await _historyPersistence.addToHistory(_calculatorService.getCalculationString());
    return result;
  }
}
