import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/notes_controller.dart';
import 'package:my_portfolio/models/notes_model.dart';
import 'package:my_portfolio/screens/apps/note/addnote.dart';
import 'package:my_portfolio/widgets/appbar_widget.dart';
import 'package:my_portfolio/widgets/custom_snackbar.dart';

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  final NotesController _notesController = Get.put(NotesController());

  Widget _body() {
    return Obx(
      () =>
          _notesController.notesList.value.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.note, size: 100, color: Colors.grey),
                    const SizedBox(height: 20),
                    Text(
                      "No notes available.",
                      style: Get.textTheme.headlineMedium,
                    ),
                  ],
                ),
              )
              : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Get.width < 500 ? 2 : Get.width ~/ 250,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.all(10),
                itemCount: _notesController.notesList.value.length,
                itemBuilder: (context, index) {
                  final note = _notesController.notesList.value[index];
                  return card(note);
                },
              ),
    );
  }

  Widget card(NotesModel note) {
    return GestureDetector(
      onTap: () => _notesController.onCardTap(note),
      onLongPress: () => _notesController.onCardLongPress(note),
      child: Obx(
        () => Stack(
          children: [
            details(note),
            if (_notesController.selectedNoteId.contains(note.id))
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.check, color: Colors.white, size: 24),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget details(note) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      margin: EdgeInsets.all(
        _notesController.selectedNoteId.contains(note.id) ? 12 : 0,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              note.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
            Flexible(
              child: Text(
                note.content,
                style: Get.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Notes"),
      body: _body(),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor:
              _notesController.selectedNoteId.isEmpty
                  ? Get.theme.primaryColor
                  : Colors.red,
          onPressed: () async {
            if (_notesController.selectedNoteId.isEmpty) {
              Get.to(
                () => AddNote(notesController: _notesController),
                transition: Transition.leftToRightWithFade,
                duration: const Duration(microseconds: 500),
              );
            } else {
              bool res = await _notesController.deleteNotes();
              if (res) {
                CustomSnackBar(
                  message: "Note deleted successfully.",
                  title: "Success",
                ).show();
              }
            }
          },
          child: Icon(
            _notesController.selectedNoteId.isEmpty ? Icons.add : Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
