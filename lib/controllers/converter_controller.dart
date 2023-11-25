import 'package:calculator_app/model/converter_model.dart';
import 'package:calculator_app/service/converter_service.dart';

class ConverterController {
  final ConverterModel model;
  final ConverterService service;

  ConverterController({required this.model, required this.service});

  void convertKilometersToMiles() {
    service.convertKilometersToMiles(model);
  }
}