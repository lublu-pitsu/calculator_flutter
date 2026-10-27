import 'package:flutter/material.dart';
import 'calculator_logic.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final logic = Logic();

  final List<String> buttons = [
    'AC', '+/-', '%', '/',
    '7', '8', '9', '*',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    'C', '0', '.', '=',
    'cos',
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(236, 0, 0, 0),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    logic.expression,
                    style: TextStyle(
                      fontSize: 32, 
                      color: Colors.white,
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    logic.display,
                    style: TextStyle(
                      fontSize: 48, 
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                )
              ],
            ),
          ),
          Divider(color: Colors.white,),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ), 
                itemBuilder: (BuildContext context, int index){
                  return customButton(buttons[index]);
                }
              ),
            )
          )
        ],
      ),
    );
  }
  Widget customButton(String text){
    return InkWell(
      splashColor: Color.fromARGB(236, 0, 0, 0),
      onTap: (){
        setState(() {
          onButtonTap(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.1),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: Offset(-3, -3),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getBgColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  
  dynamic getBgColor(String text) {
    if(text == "/" || text == "*" || text == "+" || text == "-" || text == "C" || text == "+/-" || text == "%"){
      return Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  dynamic getColor(String text) {
    if(text == "AC"){
      return Color.fromARGB(255, 252, 100, 100);
    }
    if(text == "="){
      return Color.fromARGB(255, 104, 204, 159);
    }
    return Color.fromARGB(236, 0, 0, 0);
  }

  void onButtonTap(String text) {
    setState(() {
      switch (text) {
        case 'AC':
          logic.clear();
          break;
        case 'C':
          logic.backspace();
          break;
        case '=':
          logic.calculate();
          break;
        case '+':
          logic.setOp(Op.add);
          break;
        case '-':
          logic.setOp(Op.vichitanie);
          break;
        case '*':
          logic.setOp(Op.umnozhenie);
          break;
        case '/':
          logic.setOp(Op.delenie);
          break;
        case '.':
          logic.inputD();
          break;
        case '+/-':
          logic.toggleSign();
          break;
        case '%':
          logic.prosent();
          break;
        case 'cos':
          logic.cosinus();
          break;
        default:
          logic.inputN(text);
      }
    });
  }
}