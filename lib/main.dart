import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData.dark(), // Темная тема
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String output = "0";
  String expression = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0";
        expression = "";
      } else if (buttonText == "=") {
        try {
          var exp = Expression.parse(expression);
          var evaluator = const ExpressionEvaluator();
          output = evaluator.eval(exp, {}).toString();
          expression = "";
        } catch (e) {
          output = "Error";
        }
      } else {
        expression += buttonText;
        output = expression;
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonText),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 20),
          backgroundColor: Colors.blueAccent,
          side: BorderSide(color: Colors.white),
        ),
        child: Text(buttonText, style: TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            alignment: Alignment.centerRight,
            child: Text(output,
                style: TextStyle(fontSize: 48, color: Colors.white)),
          ),
          Row(
            children: <Widget>[
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("/"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("*"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("C"),
              buildButton("0"),
              buildButton("="),
              buildButton("+"),
            ],
          ),
        ],
      ),
    );
  }
}
