import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/clock_controller.dart';

class StopwatchApp extends StatefulWidget {
  const StopwatchApp({super.key, required this.clockController});

  final ClockController clockController;

  @override
  State<StopwatchApp> createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Stopwatch'), Spacer(), _buttons()],
        ),
      ),
    );
  }

  bool show = false;

  Widget _buttons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: show ? 100 : 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              onPressed: () {},
              icon: _buttonTile(
                Icon(Icons.undo, color: Colors.white, size: 24),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            right: show ? 100 : 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              onPressed: () {},
              icon: _buttonTile(
                Icon(Icons.stop, color: Colors.white, size: 24),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                show = !show;
              });
            },
            icon: _buttonTile(
              Icon(Icons.play_arrow, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonTile(Icon icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Get.theme.primaryColor,
      ),
      child: icon,
    );
  }
}
