import 'package:calculator_app/persistence/history_persistence.dart';
import 'package:calculator_app/service/calculator_service.dart';

class CalculatorController {
  final CalculatorService _calculatorService = CalculatorService();
  final HistoryPersistence _historyPersistence = HistoryPersistence();
  String _display = '';

  // Method to handle button presses
  void onButtonPressed(String buttonText) {
    _calculatorService.updateInput(buttonText);
    // You can update the UI or perform additional logic here
  }

  // Method to calculate and return the result
  Future<double> calculateResult() async {
    double result = _calculatorService.calculate();
    await _historyPersistence.addToHistory(_calculatorService.getCalculationString());
    return result;
  }

  // Method to get the calculation history
  Future<List<String>> getHistory() async {
    List<String> historyList = await _historyPersistence.getHistory();
    return historyList;
  }

  // Getter method for the display
  String getDisplay() {
    return _display;
  }

  // Method to clear input and calculation history
  void clear() {
    _calculatorService.clear();
    _historyPersistence.clear();
  }
}

