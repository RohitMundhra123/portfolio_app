import 'package:flutter/material.dart';

class TitleTextformfield extends StatelessWidget {
  const TitleTextformfield({super.key, required this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      decoration: const InputDecoration(
        hintText: 'Title',
        border: OutlineInputBorder(),
      ),
    );
  }
}
