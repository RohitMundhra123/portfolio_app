import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleTextformfield extends StatelessWidget {
  const TitleTextformfield({
    super.key,
    required this.titleController,
    required this.focusNode,
    this.hintText,
  });

  final TextEditingController titleController;
  final FocusNode focusNode;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      style: Get.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w600),
      maxLength: 50,
      maxLines: null,
      focusNode: focusNode,

      decoration: InputDecoration(
        hintText: hintText ?? 'Heading',
        hintStyle: Get.textTheme.headlineLarge?.copyWith(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
