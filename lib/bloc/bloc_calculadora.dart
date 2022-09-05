import 'dart:async';
import 'package:calculadora/b_logic/calculadora_bl.dart';
import 'bloc.dart';

class CalculatorBloc implements Bloc {
  final _calculatorBl=CalculatorBl();
  final _calculatorController=StreamController<int>();

  Sink<int?> get pressKeySink => _calculatorController.sink;
  late Stream<String?> calculatorStream;

  CalculatorBloc() {
    calculatorStream=_calculatorController.stream.asyncMap((key) {
      return _calculatorBl.onKeyPress(key);
    });
  }

  @override
  void dispose() {
    _calculatorController.close();
  }
}