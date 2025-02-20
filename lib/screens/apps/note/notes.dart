import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/notes_controller.dart';
import 'package:my_portfolio/screens/apps/note/addnote.dart';
import 'package:my_portfolio/widgets/appbar_widget.dart';

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  final NotesController _notesController = Get.put(NotesController());

  Widget _body() {
    return const Center(child: Text('Notes'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Notes"),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Get.to(
              () => AddNote(notesController: _notesController),
              transition: Transition.leftToRightWithFade,
              duration: const Duration(microseconds: 500),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
