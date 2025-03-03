import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/controllers/time_controller.dart';
import 'package:my_portfolio/utils/widgets/painter/clock_painter.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  final TimeController _timeController = Get.find<TimeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              size: Size(200, 200),
              painter: ClockPainter(
                hour: _timeController.hour % 12,
                minute: _timeController.minute,
                second: _timeController.second,
              ),
            ),
            const SizedBox(height: 40),
            _timeTextWidget(),
            const SizedBox(height: 10),
            Text(
              DateTime.now().timeZoneName,
              style: Get.textTheme.titleLarge?.copyWith(
                color: CustomThemeData.primaryColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeTextWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _timeText(_timeController.hour.toString().padLeft(2, '0')),
        Text(' : ', style: Get.textTheme.displayLarge),
        _timeText(_timeController.minute.toString().padLeft(2, '0')),
        Text(' : ', style: Get.textTheme.displayLarge),
        _timeText(
          _timeController.second.toString().padLeft(2, '0'),
          isSecond: true,
        ),
      ],
    );
  }

  Widget _timeText(String text, {bool isSecond = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSecond ? Colors.red : CustomThemeData.primaryColorDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: Get.textTheme.displayLarge?.copyWith(
          fontFeatures: [const FontFeature.tabularFigures()],
          color: Colors.white,
        ),
      ),
    );
  }
}
