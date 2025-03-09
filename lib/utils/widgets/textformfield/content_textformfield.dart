import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentTextformfield extends StatelessWidget {
  const ContentTextformfield({
    super.key,
    required this.contentController,
    required this.focusNode,
    this.dialog = false,
    this.hintText,
  });

  final TextEditingController contentController;
  final FocusNode focusNode;
  final String? hintText;
  final bool dialog;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: contentController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      focusNode: focusNode,
      style: Get.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hintText ?? 'Content',
        hintStyle: Get.textTheme.headlineSmall?.copyWith(
          color: !dialog ? Colors.grey : null,
          fontWeight: FontWeight.w500,
        ),
        fillColor: dialog ? Colors.grey[200] : null,
        filled: dialog,
        border:
            dialog
                ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                )
                : InputBorder.none,
      ),
    );
  }
}
