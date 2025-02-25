import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClockController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  final RxBool stopWatchShowButtons = false.obs;
  final RxInt stopWatchHours = 0.obs;
  final RxInt stopWatchMinutes = 0.obs;
  final RxInt stopWatchSeconds = 0.obs;
  final RxInt stopWatchMilliseconds = 0.obs;
  String get stopWatchTime =>
      '${stopWatchHours.value > 0 ? '${stopWatchHours.value.toString().padLeft(2, '0')}:' : ''}${stopWatchMinutes.value.toString().padLeft(2, '0')}:${stopWatchSeconds.value.toString().padLeft(2, '0')}.${stopWatchMilliseconds.value.toString().padLeft(2, '0')}';

  void pageChange() {
    pageController.animateToPage(
      currentIndex.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Timer? _stopWatchTimer;

  void startStopWatch() {
    stopWatchShowButtons.value = true;

    _stopWatchTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      stopWatchMilliseconds.value++;
      if (stopWatchMilliseconds.value == 100) {
        stopWatchMilliseconds.value = 0;
        stopWatchSeconds.value++;
      }
      if (stopWatchSeconds.value == 60) {
        stopWatchSeconds.value = 0;
        stopWatchMinutes.value++;
      }
      if (stopWatchMinutes.value == 60) {
        stopWatchMinutes.value = 0;
        stopWatchHours.value++;
      }
    });
  }

  void pauseStopWatch() {
    _stopWatchTimer?.cancel();
  }

  void resetStopWatch() {
    _stopWatchTimer?.cancel();
    stopWatchShowButtons.value = false;
    stopWatchHours.value = 0;
    stopWatchMinutes.value = 0;
    stopWatchSeconds.value = 0;
    stopWatchMilliseconds.value = 0;
  }
}
