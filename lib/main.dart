import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String expression = "";
  String equation = "0";
  String result = "0";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonTap(String btnText) {
    setState(() {
      if (btnText == '=') {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = 'Error';
        }
        
        
      } else if (btnText == '⌫') {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equationFontSize = 38.0;
          resultFontSize = 48.0;
          equation = "0";
          result = "0";
        }
      } else if (btnText == 'AC') {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        equation = "0";
        result = '0';
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == '0') {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }

      print(btnText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        width: double.maxFinite,
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                        child: Text(
                          equation,
                          style: GoogleFonts.poppins(
                            fontSize: equationFontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                        child: Text(
                          result,
                          style: GoogleFonts.poppins(
                            fontSize: resultFontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfff7f7f7),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(0, 5))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton('AC', Color(0XFF5AFADC)),
                        buildButton('⌫', Color(0XFF5AFADC)),
                        buildButton('%', Color(0XFF5AFADC)),
                        buildButton('÷', Color(0XFFea5d5d)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton('7', Color(0XFF000000)),
                        buildButton('8', Color(0XFF000000)),
                        buildButton('9', Color(0XFF000000)),
                        buildButton('×', Color(0XFFea5d5d)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton('4', Color(0XFF000000)),
                        buildButton('5', Color(0XFF000000)),
                        buildButton('6', Color(0XFF000000)),
                        buildButton('-', Color(0XFFea5d5d)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton('1', Color(0XFF000000)),
                        buildButton('2', Color(0XFF000000)),
                        buildButton('3', Color(0XFF000000)),
                        buildButton('+', Color(0XFFea5d5d)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton('.', Color(0XFF000000)),
                        buildButton('0', Color(0XFF000000)),
                        buildButton('00', Color(0XFF000000)),
                        buildButton('=', Color(0XFFea5d5d)),
                      ],
                    ),
                  ],
                ),
              ),
              flex: 2,
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildButton(String btnText, Color color) {
    return GestureDetector(
      onTap: () => buttonTap(btnText),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.18,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: Color(0xfff7f7f7),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 10,
                  offset: Offset(0, 5))
            ],
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          '${btnText}',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: 22, fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
}
