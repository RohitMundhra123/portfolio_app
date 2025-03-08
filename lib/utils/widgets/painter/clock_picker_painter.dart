import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/theme.dart';

class ClockPickerPainter extends CustomPainter {
  final int? selectedHour;
  final int? selectedMinute;
  final Function(int)? onTimeChange;

  late int hour;

  ClockPickerPainter({
    required this.selectedHour,
    required this.selectedMinute,
    this.onTimeChange,
  }) {
    hour = selectedHour ?? 12;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = size.width / 2;

    final Paint backgroundPaint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill
          ..strokeWidth = 2;

    final Paint centerDial =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, backgroundPaint);

    final Paint selectedPaint =
        Paint()
          ..color = CustomThemeData.primaryColor
          ..style = PaintingStyle.fill
          ..strokeWidth = 2;

    final Paint dialPaint =
        Paint()
          ..color = CustomThemeData.primaryColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (int i = 1; i <= 12; i++) {
      final angle = -pi / 2 + (i * pi / 6);
      final double x = centerX + (radius - 25) * cos(angle);
      final double y = centerY + (radius - 25) * sin(angle);

      textPainter.text = TextSpan(
        text: (i).toString(),
        style: TextStyle(
          color: Colors.white,
          fontFamily: "monospace",
          fontSize: 16,
        ),
      );

      textPainter.layout();
      if (i == selectedHour) {
        canvas.drawCircle(Offset(x, y), textPainter.height, selectedPaint);
        canvas.drawLine(center, Offset(x, y), dialPaint);
      }
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }
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

    if (onTimeChange != null) {
      onTimeChange!(hour);
    }

    return super.hitTest(position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
