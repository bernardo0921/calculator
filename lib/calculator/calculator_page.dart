import 'package:flutter/material.dart';
import 'math_expression_evaluator.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '0'; // Changed to String for better display handling
  void buttonPressed(String value) {
    setState(() {
      if (value == "x") {
        display += "*";
      } else if (value == ("+/-")) {
        display = (int.parse(display) * -1).toString();
      } else if (value == 'C') {
        display = '0'; // Clear the display
      } else if (value == '=') {
        // Perform calculation and update display
        MathExpressionEvaluator evaluator = MathExpressionEvaluator(display);
        display = evaluator.evaluate().toString(); // Placeholder for result
      } else {
        if (display == '0') {
          display = value; // Replace zero with the first number pressed
        } else {
          display += value; // Append the value pressed
        }
      }
    });
  }

  Widget buildButton(String value,
      {bool isZeroButton = false,
      int r = 224,
      int g = 224,
      int b = 224,
      double o = 0.3}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => buttonPressed(value),
        style: ElevatedButton.styleFrom(
          shape: value == "0" // Check specifically for "0" button
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30), // Rounded corners for zero button
                )
              : const CircleBorder(), // Circular shape for all other buttons
          padding: const EdgeInsets.all(20),
          backgroundColor: Color.fromRGBO(r, g, b, o),
          foregroundColor: Colors.white,
        ),
        child: Text(value, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(24.0),
              child: Text(
                display,
                style: const TextStyle(color: Colors.white, fontSize: 48),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton('C', r: 128, g: 128, b: 128, o: 1),
                  buildButton("+/-", r: 128, g: 128, b: 128, o: 1),
                  buildButton("%", r: 128, g: 128, b: 128, o: 1),
                  buildButton("/",
                      isZeroButton: true, r: 255, g: 191, b: 0, o: 1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("x",
                      isZeroButton: true, r: 255, g: 191, b: 0, o: 1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("-",
                      isZeroButton: true, r: 255, g: 191, b: 0, o: 1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("+",
                      isZeroButton: true, r: 255, g: 191, b: 0, o: 1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2, // 50% of the space
                    child: buildButton("0",
                        isZeroButton: true), // Use default shape for "0"
                  ),
                  Expanded(
                    flex: 1, // 25% of the space
                    child: buildButton("."), // Use default shape for "."
                  ),
                  Expanded(
                    flex: 1, // 25% of the space
                    child: buildButton("=",
                        isZeroButton: true,
                        r: 255,
                        g: 191,
                        b: 0,
                        o: 1), // Use default shape for "="
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
