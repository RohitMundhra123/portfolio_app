import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentTextformfield extends StatelessWidget {
  const ContentTextformfield({
    super.key,
    required this.contentController,
    required this.focusNode,
    this.hintText,
  });

  final TextEditingController contentController;
  final FocusNode focusNode;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: contentController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      focusNode: focusNode,
      style: Get.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: hintText ?? 'Content',
        hintStyle: Get.textTheme.headlineSmall?.copyWith(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
