import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClockController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  void pageChange() {
    pageController.animateToPage(
      currentIndex.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
