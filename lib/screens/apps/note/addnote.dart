import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/notes_controller.dart';
import 'package:my_portfolio/widgets/textformfield/content_textformfield.dart';
import 'package:my_portfolio/widgets/textformfield/title_textformfield.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.notesController});

  final NotesController notesController;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late NotesController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = widget.notesController;
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
      title: const Text('Add Note'),
      actions: [
        Hero(
          tag: 'addNotes',
          child: IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _notesController.addNotes();
              Get.back();
            },
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TitleTextformfield(
              titleController: _notesController.titleController,
            ),
            const SizedBox(height: 16),
            ContentTextformfield(
              contentController: _notesController.contentController,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body());
  }
}
