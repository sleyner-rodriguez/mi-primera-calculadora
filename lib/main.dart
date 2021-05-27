import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

void main() {
  runApp(Calculadora());
}

class Calculadora extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'proyecto Calculadora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String inicial = '0';
  String resultado = "0";
  String expression = "";

  presionar(String boton) {
    setState(() {
      if (boton == "C") {
        inicial = "0";
        resultado = "0";
      } else if (boton == "DEL") {
        inicial = inicial.substring(0, inicial.length - 1);
        if (inicial == "") {
          inicial = "0";
        }
      } else if (boton == "=") {
        expression = inicial;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('+', '+');
        expression = expression.replaceAll('-', '-');
        expression = expression.replaceAll('%', '/100');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          resultado = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          resultado = "Error";
        }
      } else {
        if (inicial == "0" ||
            inicial == '.' ||
            inicial == '00' ||
            inicial == '+' ||
            inicial == '-' ||
            inicial == '×' ||
            inicial == '÷' ||
            inicial == '%') {
          inicial = boton;
        } else {
          inicial = inicial + boton;
        }
      }
    });
  }

  Widget botones(String numero, Color colorboton) {
    return FlatButton(
        color: colorboton,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200.0),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        padding: EdgeInsets.all(16.0),
        onPressed: () {
          presionar(numero);
        },
        child: Text(
          numero,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              inicial,
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              'Resultado :   ${resultado ?? ""}',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      botones("C", Colors.red),
                      botones("DEL", Colors.blue),
                      botones('%', Colors.blue),
                    ]),
                    TableRow(children: [
                      botones('7', Colors.lightBlueAccent),
                      botones('8', Colors.lightBlueAccent),
                      botones('9', Colors.lightBlueAccent),
                    ]),
                    TableRow(children: [
                      botones('4', Colors.lightBlueAccent),
                      botones('5', Colors.lightBlueAccent),
                      botones('6', Colors.lightBlueAccent),
                    ]),
                    TableRow(children: [
                      botones('1', Colors.lightBlueAccent),
                      botones('2', Colors.lightBlueAccent),
                      botones('3', Colors.lightBlueAccent),
                    ]),
                    TableRow(children: [
                      botones(".", Colors.lightBlueAccent),
                      botones('0', Colors.lightBlueAccent),
                      botones('00', Colors.lightBlueAccent),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [botones('÷', Colors.blue)]),
                    TableRow(children: [
                      botones("×", Colors.blue),
                    ]),
                    TableRow(children: [
                      botones("-", Colors.blue),
                    ]),
                    TableRow(children: [
                      botones("+", Colors.blue),
                    ]),
                    TableRow(children: [
                      botones("=", Colors.blue),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
