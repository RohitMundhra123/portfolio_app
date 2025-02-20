import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/models/notes_model.dart';
import 'package:my_portfolio/services/notes_db_service.dart';

class NotesController extends GetxController {
  final NotesDatabaseService _notesDatabaseService =
      NotesDatabaseService.instance;

  Rxn<List<NotesModel>> notesList = Rxn<List<NotesModel>>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getNotes();
  }

  getNotes() async {
    notesList.value = await _notesDatabaseService.getNotes();
  }

  addNotes() async {
    if (titleController.text != '' && contentController.text != '') {
      await _notesDatabaseService.addNotes(
        titleController.text,
        contentController.text,
      );
      titleController.clear();
      contentController.clear();
      getNotes();
    }
  }

  updateNotes(NotesModel note) async {
    await _notesDatabaseService.updateNote(note);
    getNotes();
  }

  deleteNotes(int id) async {
    await _notesDatabaseService.deleteNote(id);
    getNotes();
  }
}
