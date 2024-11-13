import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '0';
  String storedNumber = '';
  String currentOperation = '';
  bool shouldResetDisplay = false;

  void buttonPressed(String value) {
    setState(() {
      switch (value) {
        case 'C':
          _clear();
          break;
        case '+/-':
          _toggleSign();
          break;
        case '%':
          _calculatePercentage();
          break;
        case '.':
          _addDecimalPoint();
          break;
        case '+':
        case '-':
        case 'x':
        case '/':
          _handleOperation(value);
          break;
        case '=':
          _calculateResult();
          break;
        default:
          _appendNumber(value);
      }
    });
  }

  void _clear() {
    display = '0';
    storedNumber = '';
    currentOperation = '';
    shouldResetDisplay = false;
  }

  void _toggleSign() {
    if (display == '0') return;
    display = (double.parse(display) * -1).toString();
    if (display.endsWith('.0')) {
      display = display.substring(0, display.length - 2);
    }
  }

  void _calculatePercentage() {
    if (display == '0') return;
    double value = double.parse(display) / 100;
    display = value.toString();
    if (display.endsWith('.0')) {
      display = display.substring(0, display.length - 2);
    }
  }

  void _addDecimalPoint() {
    if (!display.contains('.')) {
      display = '$display.';
    }
  }

  void _handleOperation(String operation) {
    if (storedNumber.isEmpty) {
      storedNumber = display;
    } else if (currentOperation.isNotEmpty) {
      _calculateResult();
      storedNumber = display;
    }
    currentOperation = operation;
    shouldResetDisplay = true;
  }

  void _appendNumber(String number) {
    if (shouldResetDisplay) {
      display = number;
      shouldResetDisplay = false;
    } else {
      display = display == '0' ? number : display + number;
    }
  }

  void _calculateResult() {
    if (storedNumber.isEmpty || currentOperation.isEmpty) return;

    double num1 = double.parse(storedNumber);
    double num2 = double.parse(display);
    double result;

    switch (currentOperation) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case 'x':
        result = num1 * num2;
        break;
      case '/':
        if (num2 == 0) {
          display = 'Error';
          storedNumber = '';
          currentOperation = '';
          return;
        }
        result = num1 / num2;
        break;
      default:
        return;
    }

    display = result.toString();
    if (display.endsWith('.0')) {
      display = display.substring(0, display.length - 2);
    }
    storedNumber = '';
    currentOperation = '';
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
          shape: value == "0"
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )
              : const CircleBorder(),
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
    // Build method remains unchanged
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
                  buildButton("/", r: 255, g: 191, b: 0, o: 1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("x", r: 255, g: 191, b: 0, o: 1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("-", r: 255, g: 191, b: 0, o: 1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("+", r: 255, g: 191, b: 0, o: 1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: buildButton("0", isZeroButton: true),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildButton("."),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildButton("=", r: 255, g: 191, b: 0, o: 1),
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
