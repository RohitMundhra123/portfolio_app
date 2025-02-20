import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/time_controller.dart';
import 'package:my_portfolio/screens/homescreen.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen>
    with SingleTickerProviderStateMixin {
  final TimeController _timeController = Get.find<TimeController>();

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.5),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _lockIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 36),
            const SizedBox(height: 10),
            Obx(
              () => Text(
                _timeController.timeString,
                style: Get.textTheme.displayLarge?.copyWith(fontSize: 48),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _swipeToUnlock() {
    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        return SlideTransition(position: _offsetAnimation, child: child);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.keyboard_arrow_up, size: 36),
          Text('Swipe to unlock', style: Get.textTheme.headlineSmall),
        ],
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [_lockIcon(), Spacer(), _swipeToUnlock()]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            debugPrint('Swipe up');
            Get.off(() => HomeScreen(), transition: Transition.fade);
          }
        },
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            debugPrint('Swipe left');
            Get.off(() => HomeScreen(), transition: Transition.fade);
          }
        },
        child: Container(color: Colors.white, child: SafeArea(child: _body())),
      ),
    );
  }
}
