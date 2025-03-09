import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/theme.dart';

class MinutePickerPainter extends CustomPainter {
  final int selectedMinute;
  final Function(int)? onTimeChange;

  MinutePickerPainter({required this.selectedMinute, this.onTimeChange});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = size.width / 2;

    final Paint backgroundPaint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill;

    final Paint centerDialPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, backgroundPaint);

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (int i = 0; i <= 11; i++) {
      final angle = -pi / 2 + (i * pi / 6);
      final double x = centerX + (radius - 25) * cos(angle);
      final double y = centerY + (radius - 25) * sin(angle);

      textPainter.text = TextSpan(
        text: (i * 5).toString(),
        style: TextStyle(
          color:
              i * 5 == selectedMinute
                  ? CustomThemeData.accentColor
                  : Colors.white,
          fontFamily: "monospace",
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }

    final Paint subMinutePaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
    final Paint minutePaint =
        Paint()
          ..color = CustomThemeData.accentColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;

    for (int i = 0; i <= 59; i++) {
      final angle = -pi / 2 + (i * pi / 30);
      final double x = centerX + (radius - 8) * cos(angle);
      final double y = centerY + (radius - 8) * sin(angle);
      final double x1 = centerX + (radius / 1.75) * cos(angle);
      final double y1 = centerY + (radius / 1.75) * sin(angle);

      if (i == selectedMinute) {
        subMinutePaint.color = CustomThemeData.accentColor;
        subMinutePaint.strokeWidth = 4;
      } else {
        subMinutePaint.color = Colors.white;
        subMinutePaint.strokeWidth = 2;
      }

      canvas.drawLine(
        Offset(centerX + radius * cos(angle), centerY + radius * sin(angle)),
        Offset(x, y),
        subMinutePaint,
      );

      if (i == selectedMinute) {
        canvas.drawLine(Offset(x1, y1), center, minutePaint);
        final dx = x1 - centerX;
        final dy = y1 - centerY;
        final angle = atan2(dy, dx);
        final arrowSize = 10;
        final arrowAngle = pi / 5;
        final arrow1 = Offset(
          x1 - arrowSize * cos(angle + arrowAngle),
          y1 - arrowSize * sin(angle + arrowAngle),
        );
        final arrow2 = Offset(
          x1 - arrowSize * cos(angle - arrowAngle),
          y1 - arrowSize * sin(angle - arrowAngle),
        );
        final Path path =
            Path()
              ..moveTo(x1, y1)
              ..lineTo(arrow1.dx, arrow1.dy)
              ..lineTo(arrow2.dx, arrow2.dy)
              ..close();

        canvas.drawPath(path, minutePaint);
      }
    }

    canvas.drawCircle(center, 4, centerDialPaint);
  }

  @override
  bool? hitTest(Offset position) {
    final dx = position.dx;
    final dy = position.dy;
    final centerX = 200 / 2;
    final centerY = 200 / 2;
    final angle = atan2(dy - centerY, dx - centerX);

    final adjustedAngle = (angle + pi / 2) % (2 * pi);
    final selectedMinute = (adjustedAngle / (pi / 30)).round() % 60;

    if (onTimeChange != null) {
      onTimeChange!(selectedMinute);
    }

    return super.hitTest(position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
