import 'dart:math';

class MathExpressionEvaluator {
  String expression;

  MathExpressionEvaluator(this.expression);

  double evaluate() {
    return _parseExpression(expression);
  }

  double _parseExpression(String expression) {
    // Remove whitespace
    expression = expression.replaceAll(' ', '');

    // Evaluate expressions inside brackets first
    while (expression.contains('(')) {
      int start = expression.indexOf('(');
      int end = expression.indexOf(')');
      String innerExpression = expression.substring(start + 1, end);
      double result = _parseInnerExpression(innerExpression);
      expression = expression.replaceRange(start, end + 1, result.toString());
    }

    // Evaluate the remaining expression
    return _parseInnerExpression(expression);
  }

  double _parseInnerExpression(String expression) {
    // Orders (exponents)
    while (expression.contains('^')) {
      int index = expression.indexOf('^');
      String base = expression.substring(0, index);
      String exponent = expression.substring(index + 1);
      num result = pow(double.parse(base), double.parse(exponent));
      expression = result.toString();
    }

    // Division and Multiplication
    while (expression.contains('/') || expression.contains('*')) {
      int divIndex = expression.indexOf('/');
      int mulIndex = expression.indexOf('*');
      if (divIndex != -1 && (mulIndex == -1 || divIndex < mulIndex)) {
        String numerator = expression.substring(0, divIndex);
        String denominator = expression.substring(divIndex + 1);
        double result = double.parse(numerator) / double.parse(denominator);
        expression = result.toString();
      } else {
        String factors = expression.substring(0, mulIndex);
        String multiplier = expression.substring(mulIndex + 1);
        double result = double.parse(factors) * double.parse(multiplier);
        expression = result.toString();
      }
    }

    // Addition and Subtraction
    while (expression.contains('+') || expression.contains('-')) {
      int addIndex = expression.indexOf('+');
      int subIndex = expression.indexOf('-');
      if (addIndex != -1 && (subIndex == -1 || addIndex < subIndex)) {
        String augend = expression.substring(0, addIndex);
        String addend = expression.substring(addIndex + 1);
        double result = double.parse(augend) + double.parse(addend);
        expression = result.toString();
      } else {
        String minuend = expression.substring(0, subIndex);
        String subtrahend = expression.substring(subIndex + 1);
        double result = double.parse(minuend) - double.parse(subtrahend);
        expression = result.toString();
      }
    }

    return double.parse(expression);
  }
}
