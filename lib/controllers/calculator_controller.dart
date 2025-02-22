import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/utils/calculatorhelper.dart';

class CalculatorController extends GetxController {
  TextEditingController expressionController = TextEditingController();
  RxString answer = ''.obs;
  RxBool isAnswer = false.obs;

  void onKeyTap(String key) {
    if (isAnswer.value) {
      isAnswer.value = false;
    }
    if (key == 'C') {
      expressionController.clear();
      answer.value = '';
    } else if (key == 'DEL') {
      if (expressionController.text.isNotEmpty) {
        expressionController.text = expressionController.text.substring(
          0,
          expressionController.text.length - 1,
        );
        if (expressionController.text.isEmpty) {
          answer.value = '';
        } else {
          calculate(
            (expressionController.text[expressionController.text.length - 1] ==
                        '/' ||
                    expressionController.text[expressionController.text.length -
                            1] ==
                        'x' ||
                    expressionController.text[expressionController.text.length -
                            1] ==
                        '-' ||
                    expressionController.text[expressionController.text.length -
                            1] ==
                        '+')
                ? expressionController.text.substring(
                  0,
                  expressionController.text.length - 1,
                )
                : expressionController.text,
          );
        }
      }
    } else if (key == '=') {
      if (isAnswer.value) {
        if (answer.value != 'Error') {
          expressionController.text = answer.value;
          answer.value = '';
          isAnswer.value = false;
        } else {
          expressionController.clear();
        }
      } else {
        isAnswer.value = true;
      }
      calculate(null);
    } else {
      checkAndAdd(key);
    }
  }

  calculate(String? expression) {
    try {
      answer.value = CalculatorHelper.evaluate(
        expression ?? expressionController.text,
      );
    } catch (e) {
      answer.value = 'Error';
    }
  }

  checkAndAdd(String key) {
    if (key == '%' || key == '/' || key == 'x' || key == '-' || key == '+') {
      if (expressionController.text.isNotEmpty) {
        if (CalculatorHelper.operators.contains(
          expressionController.text[expressionController.text.length - 1],
        )) {
          expressionController.text = expressionController.text.substring(
            0,
            expressionController.text.length - 1,
          );
        }
        expressionController.text += key;
        if (key == '%') {
          calculate(null);
        }
      }
    } else if (key == '.') {
      if (expressionController.text.isEmpty) {
        expressionController.text += '.';
      } else {
        List<String> numbers = expressionController.text.split(
          RegExp(r'[%/x+-]'),
        );
        String lastNumber = numbers[numbers.length - 1];
        if (!lastNumber.contains('.')) {
          expressionController.text += key;
        }
      }
    } else {
      expressionController.text += key;
      calculate(null);
    }
  }
}
