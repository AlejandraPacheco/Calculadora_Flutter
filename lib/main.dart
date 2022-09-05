import 'package:flutter/material.dart';
import 'package:calculadora/widgets/botones.dart';

import 'package:calculadora/bloc/bloc_provider.dart';
import 'package:calculadora/bloc/bloc_calculadora.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: CalculatorBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion='';
  var userAnswer='';
  //var errorCero='';
  //bool puntoTap=false;

  final List<String> buttons=[
    'C', 'DEL', '=', '/',
    '7', '8', '9', 'x',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '0', '.',
  ];

  @override
  Widget build(BuildContext context) {
    final calculatorBloc=BlocProvider.of<CalculatorBloc>(context);
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
                    child: _buildAnswerText(calculatorBloc),
                  ),
                  /*Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(errorCero, style: TextStyle(fontSize: 15, color: Colors.red),),
                  ),*/
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
                      return MyButton(
                        buttonTap:() {
                          calculatorBloc.pressKeySink.add(index);
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

  Widget _buildAnswerText(CalculatorBloc bloc) {
    return StreamBuilder<String?>(
      stream: bloc.calculatorStream,
      builder: (context, snapshot) {
        print("StreamBuilder: ${snapshot.data}"); // Muestra lo que sale en pantalla
        var answer="";
        if (snapshot.data!=null) {
          answer=snapshot.data.toString();
        }
        return Text(
          answer,
          style: const TextStyle(
              fontSize: 30,),
        );
      },
    );
  }
}
