import 'package:math_expressions/math_expressions.dart';

class CalculatorBl {
  var userQuestion='';
  var userAnswer='';
  var errorCero='';
  final List<String> buttons=[
    'C', 'DEL', '=', '/',
    '7', '8', '9', 'x',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '0', '.',
  ];

  String onKeyPress(int keyIndex) {
    var isButtonEqual=false;
    if (keyIndex==0) { // Boton C
      userQuestion='';
      userAnswer='';
    } else if (keyIndex==1) { // Boton DEL
      userQuestion=userQuestion.substring(0, userQuestion.length-1);
    } else if (keyIndex == 2) { // Boton =
      isButtonEqual=true;
      igual();
    } else {
      userQuestion+=buttons[keyIndex];
    }
    return isButtonEqual ? userAnswer : userQuestion;
  }

  void igual(){
    String finalQuestion=userQuestion;
    finalQuestion=finalQuestion.replaceAll('x', '*');
    Parser p= Parser();
    Expression exp= p.parse(finalQuestion);
    ContextModel cm= ContextModel();
    double eval=exp.evaluate(EvaluationType.REAL, cm);

    userAnswer=eval.toString();
    userQuestion=userAnswer;
  }
}