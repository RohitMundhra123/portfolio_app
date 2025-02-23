import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/calendar_controller.dart';

import 'package:my_portfolio/models/calendar_model.dart';

import 'package:my_portfolio/utils/widgets/custom_snackbar.dart';
import 'package:my_portfolio/utils/widgets/textformfield/content_textformfield.dart';
import 'package:my_portfolio/utils/widgets/textformfield/title_textformfield.dart';

class AddCalendarEvent extends StatefulWidget {
  const AddCalendarEvent({
    super.key,
    required this.calendarController,
    this.calendarModel,
  });

  final CalendarController calendarController;
  final CalendarModel? calendarModel;

  @override
  State<AddCalendarEvent> createState() => _AddCalendarEventState();
}

class _AddCalendarEventState extends State<AddCalendarEvent> {
  late CalendarController _calendarController;
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late bool _isEdit;

  @override
  void initState() {
    super.initState();
    _calendarController = widget.calendarController;
    _titleFocusNode.requestFocus();
    _isEdit = widget.calendarModel != null;
    if (_isEdit) {
      _titleController.text = widget.calendarModel!.title;
      _contentController.text = widget.calendarModel!.description;
    }
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _scrollController.dispose();
    _contentFocusNode.dispose();
    _titleController.clear();
    _contentController.clear();
    super.dispose();
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
      title: Text(_calendarController.formatDateForDb),
      actions: [
        IconButton(
          icon: const Icon(Icons.save_outlined),
          onPressed: () async {
            if (_isEdit) {
              bool res = await _calendarController.updateEvent(
                CalendarModel(
                  id: widget.calendarModel!.id,
                  date: _calendarController.formatDateForDb,
                  title: _titleController.text,
                  description: _contentController.text,
                  time: DateTime.now(),
                ),
              );
              if (res) {
                Get.back();
                CustomSnackBar(
                  message: "Event updated successfully.",
                  title: "Success",
                ).show();
              }
              return;
            } else {
              bool res = await _calendarController.addEvent(
                _calendarController.formatDateForDb,
                _titleController.text,
                _contentController.text,
                DateTime.now(),
              );
              if (res) {
                Get.back();
                CustomSnackBar(
                  message: "Event added successfully.",
                  title: "Success",
                ).show();
              }
            }
          },
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
                titleController: _titleController,
                focusNode: _titleFocusNode,
                hintText: "Event Title",
              ),
              const SizedBox(height: 16),
              ContentTextformfield(
                contentController: _contentController,
                focusNode: _contentFocusNode,
                hintText: "Event Description",
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
