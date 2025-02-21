import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  CustomSnackBar({required this.title, required this.message, this.icon});

  final String title;
  final String message;
  final IconData? icon;

  void show() {
    Color color =
        (title == 'Success')
            ? Colors.green
            : (title == 'Warning')
            ? Colors.yellow
            : Colors.red;
    Color textColor =
        (title == 'Success')
            ? Colors.white
            : (title == 'Warning')
            ? Colors.black
            : Colors.white;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      colorText: textColor,
      titleText: Text(
        title,
        style: Get.textTheme.headlineSmall?.copyWith(color: textColor),
      ),
      messageText: Text(
        message,
        style: Get.textTheme.titleMedium?.copyWith(color: textColor),
      ),
      icon: icon == null ? null : Icon(icon, color: textColor),
    );
  }
}
