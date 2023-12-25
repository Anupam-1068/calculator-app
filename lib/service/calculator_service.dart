class CalculatorService {
  String _input = '';

  void updateInput(String value) {
    _input += value;
  }

  double calculate() {
    try {
      // Split the input into operands and operator
      List<String> inputParts = _input.split(RegExp(r'[-+*/]'));
      double operand1 = double.parse(inputParts[0]);
      double operand2 = double.parse(inputParts[1]);

      // Get the operator
      String operator = _input[inputParts[0].length];

      // Perform the calculation
      switch (operator) {
        case '+':
          return operand1 + operand2;
        case '-':
          return operand1 - operand2;
        case '*':
          return operand1 * operand2;
        case '/':
          if (operand2 != 0) {
            return operand1 / operand2;
          } else {
            // Handle division by zero
            return double.infinity;
          }
      }
    } catch (e) {
      // Handle parsing errors or other exceptions
      print('Error: $e');
    }

    // Return NaN for other error cases
    return 0;
  }

  String getCalculationString() {
    return _input;
  }

  // Method to clear input
  void clear() {
    _input = '';
  }
}

