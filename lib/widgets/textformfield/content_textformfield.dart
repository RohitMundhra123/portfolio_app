import 'package:flutter/material.dart';

class ContentTextformfield extends StatelessWidget {
  const ContentTextformfield({super.key, required this.contentController});

  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: contentController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: const InputDecoration(
        hintText: 'Content',
        border: OutlineInputBorder(),
      ),
    );
  }
}
