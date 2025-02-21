import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/notes_controller.dart';
import 'package:my_portfolio/models/notes_model.dart';
import 'package:my_portfolio/widgets/custom_snackbar.dart';
import 'package:my_portfolio/widgets/textformfield/content_textformfield.dart';
import 'package:my_portfolio/widgets/textformfield/title_textformfield.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.notesController, this.note});

  final NotesController notesController;
  final NotesModel? note;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late NotesController _notesController;
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  late bool _isEdit;

  @override
  void initState() {
    super.initState();
    _notesController = widget.notesController;
    _titleFocusNode.requestFocus();
    _isEdit = widget.note != null;
    if (_isEdit) {
      _notesController.titleController.text = widget.note!.title;
      _notesController.contentController.text = widget.note!.content;
    }
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollToBottom();
    // });
  }

  // void _scrollToBottom() {
  //   _scrollController.animateTo(
  //     100,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeOut,
  //   );
  // }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _scrollController.dispose();
    _contentFocusNode.dispose();
    _notesController.titleController.clear();
    _notesController.contentController.clear();
    super.dispose();
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
            icon: const Icon(Icons.save_outlined),
            onPressed: () async {
              if (_isEdit) {
                bool res = await _notesController.updateNotes(widget.note!.id);
                if (res) {
                  Get.back();
                  CustomSnackBar(
                    message: "Note updated successfully.",
                    title: "Success",
                  ).show();
                }
                return;
              } else {
                bool res = await _notesController.addNotes();
                if (res) {
                  Get.back();
                  CustomSnackBar(
                    message: "Note added successfully.",
                    title: "Success",
                  ).show();
                }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: GestureDetector(
        onTap: () {
          if (_contentFocusNode.hasFocus) {
            _contentFocusNode.unfocus();
          } else {
            _titleFocusNode.unfocus();
            _contentFocusNode.requestFocus();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          height: Get.height,
          color: Colors.transparent,
          child: Column(
            children: [
              TitleTextformfield(
                titleController: _notesController.titleController,
                focusNode: _titleFocusNode,
              ),
              const SizedBox(height: 16),
              ContentTextformfield(
                contentController: _notesController.contentController,
                focusNode: _contentFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body());
  }
}
