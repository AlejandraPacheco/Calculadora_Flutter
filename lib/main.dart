import 'package:flutter/material.dart';
import 'package:calculadora/botones.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var userQuestion='';
  var userAnswer='';
  var errorCero='';
  bool puntoTap=false;


  final List<String> buttons=[
    'C', 'DEL', '=', '/',
    '7', '8', '9', 'x',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '0', '.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 40,),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion, style: TextStyle(fontSize: 30),),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer, style: TextStyle(fontSize: 30),),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(errorCero, style: TextStyle(fontSize: 15, color: Colors.red),),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: GridView.builder(
                  itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index){

                      // Boton C
                      if(index==0){
                        return MyButton(
                          buttonTap: (){
                            setState(() {
                              userQuestion='';
                              userAnswer='';
                              puntoTap=false;
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.teal,
                          textColor: Colors.black,
                        );
                      }

                      // Boton DEL
                      if(index==1){
                        return MyButton(
                          buttonTap: (){
                            setState(() {
                              userQuestion=userQuestion.substring(0,userQuestion.length-1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.teal,
                          textColor: Colors.black,
                        );
                      }

                      // Boton =
                      if(index==2){
                        return MyButton(
                          buttonTap: (){
                            setState(() {
                              igual();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.teal,
                          textColor: Colors.black,
                        );
                      }

                      // Boton /
                      if(index==3){
                        return MyButton(
                          buttonTap: (){
                            setState(() {
                              puntoTap=false;
                              userQuestion+=buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.black,
                          textColor: Colors.white,
                        );
                      }

                      // Boton x
                      if(index==7){
                        return MyButton(
                          buttonTap: (){
                            setState(() {
                              puntoTap=false;
                              userQuestion+=buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.black,
                          textColor: Colors.white,
                        );
                      }

                      // Boton -
                      if(index==11){
                        return MyButton(
                          buttonTap: (){
                            setState(() {
                              puntoTap=false;
                              userQuestion+=buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.black,
                          textColor: Colors.white,
                        );
                      }

                      // Boton +
                      if(index==15){
                        return MyButton(
                          buttonTap: (){
                            setState(() {
                              puntoTap=false;
                              userQuestion+=buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.black,
                          textColor: Colors.white,
                        );
                      }

                      // Boton .
                      if(index==17){
                        return MyButton(
                          buttonTap: (){
                            if(puntoTap==false){
                              setState(() {
                                puntoTap=true;
                                userQuestion+=buttons[index];
                              });
                            }
                            else{
                              userQuestion=userQuestion;
                            };
                          },
                          buttonText: buttons[index],
                          color: Colors.teal,
                          textColor: Colors.black,
                        );
                      }

                      return MyButton(
                        buttonTap: (){
                            setState(() {
                              userQuestion+=buttons[index];
                            });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index]) ? Colors.black : Colors.teal,
                        textColor: isOperator(buttons[index]) ? Colors.white : Colors.black,
                      );
                    }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x){
    if(x=='/' || x=='x' || x=='-' || x=='+' || x=='='){
      //puntoTap=false;
      return true;
    }
    return false;
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
    puntoTap=false;

    if(userAnswer=='NaN' || userAnswer=='Infinity' || userAnswer=='-Infinity'){
      errorCero='No se puede dividir entre cero';
      userQuestion='';
    }
    else{
      errorCero='';
    }
  }
}
