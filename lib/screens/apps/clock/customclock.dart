import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('CustomPaint Basics')),
        body: Center(
          child: CustomPaint(size: Size(200, 200), painter: MyPainter()),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
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
          ..color = Colors.white
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

    final now = DateTime.now();
    final hour = now.hour % 12;
    final minute = now.minute;
    final second = now.second;

    final hourAngle = -pi / 2 + (hour + minute / 60) * (pi / 6);
    final hourHandLength = radius * 0.4;
    canvas.drawLine(
      center,
      Offset(
        centerX + cos(hourAngle) * hourHandLength,
        centerY + sin(hourAngle) * hourHandLength,
      ),
      dialPaint,
    );

    final minuteAngle = -pi / 2 + (minute + second / 60) * (pi / 30);
    final minuteHandLength = radius * 0.6;
    canvas.drawLine(
      center,
      Offset(
        centerX + cos(minuteAngle) * minuteHandLength,
        centerY + sin(minuteAngle) * minuteHandLength,
      ),
      dialPaint,
    );

    final secondAngle = -pi / 2 + second * (pi / 30);
    final secondHandLength = radius * 0.8;
    canvas.drawLine(
      center,
      Offset(
        centerX + cos(secondAngle) * secondHandLength,
        centerY + sin(secondAngle) * secondHandLength,
      ),
      dialPaint..color = Colors.red,
    );

    canvas.drawCircle(center, 2, centerDial);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
