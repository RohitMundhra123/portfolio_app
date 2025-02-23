import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/models/notes_model.dart';
import 'package:my_portfolio/screens/apps/note/addnote.dart';
import 'package:my_portfolio/services/notes_db_service.dart';
import 'package:my_portfolio/utils/widgets/custom_snackbar.dart';

class NotesController extends GetxController {
  final NotesDatabaseService _notesDatabaseService =
      NotesDatabaseService.instance;

  Rx<List<NotesModel>> notesList = Rx<List<NotesModel>>([]);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  RxBool isDeleteUI = false.obs;
  RxList<int> selectedNoteId = RxList<int>([]);

  onCardTap(NotesModel note) {
    if (isDeleteUI.value) {
      if (selectedNoteId.contains(note.id)) {
        selectedNoteId.remove(note.id);
        if (selectedNoteId.isEmpty) {
          isDeleteUI.value = false;
        }
      } else {
        selectedNoteId.add(note.id);
      }
    } else {
      Get.to(() => AddNote(notesController: this, note: note), arguments: note);
    }
  }

  onCardLongPress(NotesModel note) {
    if (!isDeleteUI.value) {
      isDeleteUI.value = true;
      selectedNoteId.add(note.id);
    } else {
      if (selectedNoteId.contains(note.id)) {
        selectedNoteId.remove(note.id);
        if (selectedNoteId.isEmpty) {
          isDeleteUI.value = false;
        }
      } else {
        selectedNoteId.add(note.id);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getNotes();
  }

  getNotes() async {
    notesList.value.insertAll(
      0,
      (await _notesDatabaseService.getNotes()).reversed.toList(),
    );
    notesList.refresh();
  }

  Future<bool> addNotes() async {
    if (titleController.text != '' && contentController.text != '') {
      final res = await _notesDatabaseService.addNotes(
        titleController.text,
        contentController.text,
      );
      if (res == 0) {
        CustomSnackBar(
          message: "Hey! Something went wrong.",
          title: "Error",
        ).show();
        return false;
      } else {
        notesList.value.insert(
          0,
          NotesModel(
            id: res,
            title: titleController.text,
            content: contentController.text,
            date: DateTime.now().toUtc().toString(),
          ),
        );
        notesList.refresh();
        titleController.clear();
        contentController.clear();
        return true;
      }
    } else {
      CustomSnackBar(
        message: "Hey! You can't leave any field empty.",
        title: "Warning",
      ).show();
      return false;
    }
  }

  Future<bool> updateNotes(int id) async {
    if (titleController.text == '' || contentController.text == '') {
      CustomSnackBar(
        message: "Hey! You can't leave any field empty.",
        title: "Warning",
      ).show();
      return false;
    } else {
      final note = NotesModel(
        id: id,
        title: titleController.text,
        content: contentController.text,
        date: DateTime.now().toUtc().toString(),
      );
      int res = await _notesDatabaseService.updateNote(note);
      if (res == 0) {
        CustomSnackBar(
          message: "Hey! Something went wrong.",
          title: "Error",
        ).show();
        return false;
      } else {
        notesList.value.removeWhere((element) => element.id == id);
        notesList.value.insert(0, note);
        notesList.refresh();
        return true;
      }
    }
  }

  Future<bool> deleteNotes() async {
    if (selectedNoteId.isNotEmpty) {
      final res = await _notesDatabaseService.deleteNotes(selectedNoteId);

      if (res == 0) {
        CustomSnackBar(
          message: "Hey! Something went wrong.",
          title: "Error",
        ).show();
        return false;
      } else {
        notesList.value.removeWhere(
          (element) => selectedNoteId.contains(element.id),
        );
        notesList.refresh();
        selectedNoteId.clear();
        isDeleteUI.value = false;
        return true;
      }
    } else {
      CustomSnackBar(
        message: "Hey! You haven't selected any note.",
        title: "Warning",
      ).show();
      return false;
    }
  }
}
