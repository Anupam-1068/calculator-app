import 'package:calculator_app/model/converter_model.dart';

class ConverterService {
  void convertKilometersToMiles(ConverterModel model) {
    double kilometers =
        double.tryParse(model.kilometerController.text) ?? 0.0;
    double miles = kilometers * 0.621371;
    model.mileController.text = miles.toStringAsFixed(2);
  }
}