class CalculatorHelper {
  static List<String> operations = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '=',
  ];

  static List<String> operators = ['%', '/', 'x', '-', '+'];

  static String evaluate(String expression) {
    
    expression = expression.replaceAll('x', '*');
    expression = expression.replaceAll('%', '/100');
    expression = expression.replaceAll(',', '');

    return calculate(expression);
  }

  static String calculate(String expression) {
    List<String> operators = ['/', '*', '+', '-'];
    List<String> expressionList = expression.split('');
    List<String> numbers = [];
    List<String> ops = [];

    String num = '';

    for (int i = 0; i < expressionList.length; i++) {
      if (operators.contains(expressionList[i])) {
        numbers.add(num);
        num = '';
        ops.add(expressionList[i]);
      } else {
        num += expressionList[i];
      }
    }

    numbers.add(num);

    for (int i = 0; i < operators.length; i++) {
      for (int j = 0; j < ops.length; j++) {
        if (operators[i] == ops[j]) {
          double result = 0;
          if (operators[i] == '+') {
            result = double.parse(numbers[j]) + double.parse(numbers[j + 1]);
          } else if (operators[i] == '-') {
            result = double.parse(numbers[j]) - double.parse(numbers[j + 1]);
          } else if (operators[i] == '*') {
            result = double.parse(numbers[j]) * double.parse(numbers[j + 1]);
          } else if (operators[i] == '/') {
            result = double.parse(numbers[j]) / double.parse(numbers[j + 1]);
          }

          numbers[j] = result.toString();
          numbers.removeAt(j + 1);
          ops.removeAt(j);
          j--;
        }
      }
    }

    return double.parse(
      numbers[0],
    ).toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
  }
}
