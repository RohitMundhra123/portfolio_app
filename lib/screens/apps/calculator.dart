import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/calculator_controller.dart';
import 'package:my_portfolio/utils/calculatorhelper.dart';
import 'package:my_portfolio/utils/widgets/appbar_widget.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final CalculatorController _calculatorController = Get.put(
    CalculatorController(),
  );

  Widget _textArea() {
    return Obx(
      () => TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 1,
        minLines: 1,
        autofocus: true,
        onTap: () {
          if (_calculatorController.isAnswer.value) {
            _calculatorController.isAnswer.value = false;
          }
        },
        controller: _calculatorController.expressionController,
        textAlign: TextAlign.end,
        readOnly: true,
        showCursor: true,
        style:
            _calculatorController.isAnswer.value
                ? Get.textTheme.headlineLarge?.copyWith(color: Colors.grey)
                : Get.textTheme.displayLarge,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Widget _keyCard(String text) {
    return InkWell(
      onTap: () {
        _calculatorController.onKeyTap(text);
      },
      child: Card(
        color:
            text == '='
                ? Colors.green
                : text == 'C' || text == 'DEL'
                ? Colors.red
                : CalculatorHelper.operators.contains(text)
                ? Colors.grey
                : null,

        child: Center(
          child: Text(
            text,
            style: Get.textTheme.headlineMedium?.copyWith(
              color:
                  CalculatorHelper.operators.contains(text)
                      ? Colors.black
                      : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _keyPad() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: CalculatorHelper.operations.length,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return _keyCard(CalculatorHelper.operations[index]);
      },
    );
  }

  _ansArea() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 10, top: 10),
      child: Obx(
        () => Text(
          _calculatorController.answer.value,
          style:
              _calculatorController.isAnswer.value
                  ? Get.textTheme.displayLarge
                  : Get.textTheme.headlineLarge,
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [Spacer(), _textArea(), _ansArea(), _keyPad()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: customAppBar("Calculator"), body: _body());
  }
}
