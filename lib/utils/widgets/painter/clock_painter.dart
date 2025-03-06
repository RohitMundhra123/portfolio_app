import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/constants/theme.dart';

class ClockPainter extends CustomPainter {
  ClockPainter({
    required this.hour,
    required this.minute,
    required this.second,
    this.onTimeChange,
  });

  final int hour;
  final int minute;
  final int second;
  final Function(int)? onTimeChange;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

    final Paint backGroundPaint =
        Paint()
          ..color = Colors.black
          ..maskFilter = MaskFilter.blur(BlurStyle.solid, 15)
          ..style = PaintingStyle.fill;

    final Paint centerDial =
        Paint()
          ..color = Get.theme.primaryColor
          ..style = PaintingStyle.fill;

    final Paint dialPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    canvas.drawCircle(center, radius, backGroundPaint);

    for (int i = 1; i <= 12; i++) {
      final angle = -pi / 2 + (i * pi / 6);
      final double x = centerX + (radius - 20) * cos(angle);
      final double y = centerY + (radius - 20) * sin(angle);
      textPainter.text = TextSpan(
        text: (i).toString(),
        style: TextStyle(
          color: Colors.white,
          fontFamily: "monospace",
          fontSize: 16,
        ),
      );
      textPainter.layout();
      final textWidth = textPainter.width;
      final textHeight = textPainter.height;
      textPainter.paint(canvas, Offset(x - textWidth / 2, y - textHeight / 2));
    }

    final hourAngle = -pi / 2 + (hour + minute / 60) * (pi / 6);
    final hourHandLength = radius * 0.4;
    canvas.drawLine(
      center,
      Offset(
        centerX + cos(hourAngle) * hourHandLength,
        centerY + sin(hourAngle) * hourHandLength,
      ),
      dialPaint..strokeWidth = 4,
    );

    final secondAngle = -pi / 2 + second * (pi / 30);
    final secondHandLength = radius * 0.75;
    canvas.drawLine(
      center,
      Offset(
        centerX + cos(secondAngle) * secondHandLength,
        centerY + sin(secondAngle) * secondHandLength,
      ),
      dialPaint
        ..color = Colors.red
        ..strokeWidth = 2,
    );

    final minuteAngle = -pi / 2 + (minute + second / 60) * (pi / 30);
    final minuteHandLength = radius * 0.65;
    canvas.drawLine(
      center,
      Offset(
        centerX + cos(minuteAngle) * minuteHandLength,
        centerY + sin(minuteAngle) * minuteHandLength,
      ),
      dialPaint
        ..strokeWidth = 3
        ..color = CustomThemeData.accentColor,
    );

    canvas.drawCircle(center, 4, centerDial);
  }

  @override
  bool? hitTest(Offset position) {
    final dx = position.dx;
    final dy = position.dy;
    final centerX = 200 / 2;
    final centerY = 200 / 2;
    final angle = atan2(dy - centerY, dx - centerX);
    final adjustedAngle = (angle + pi / 2) % (2 * pi);
    final hour = (adjustedAngle / (pi / 6)).round() % 12;
    print(hour);
    if (onTimeChange != null) {
      onTimeChange!(hour);
    }
    return super.hitTest(position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
