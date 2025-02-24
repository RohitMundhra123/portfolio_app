import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/constants/theme.dart';
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
  RxInt _hour = DateTime.now().hour.obs;
  RxInt _minute = DateTime.now().minute.obs;
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
            if (_titleController.text.isEmpty) {
              CustomSnackBar(
                message: "Title can't be empty.",
                title: "Error",
              ).show();
              return;
            }
            if (_contentController.text.isEmpty) {
              CustomSnackBar(
                message: "Description can't be empty.",
                title: "Error",
              ).show();
              return;
            }

            if (_isEdit) {
              bool res = await _calendarController.updateEvent(
                CalendarModel(
                  id: widget.calendarModel!.id,
                  date: _calendarController.formatDateForDb,
                  title: _titleController.text,
                  description: _contentController.text,
                  time: DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    _hour.value,
                    _minute.value,
                  ),
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
                DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  _hour.value,
                  _minute.value,
                ),
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
              _dateTile(),
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

  Widget _dateTile() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 30),
      child: GestureDetector(
        onTap: () {
          Get.dialog(_setTimeDialog());
        },
        child: Row(
          children: [
            const Icon(Icons.lock_clock),
            const SizedBox(width: 10),
            Text(
              "Set Time",
              style: Get.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Obx(
              () => Text(
                "${_hour.toString().padLeft(2, '0')} : ${_minute.toString().padLeft(2, '0')}",
                style: Get.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _setTimeDialog() {
    return AlertDialog(
      backgroundColor: Get.theme.primaryColor,
      title: Text(
        "Set Time",
        style: Get.textTheme.headlineMedium?.copyWith(color: Colors.white),
      ),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _timeText(true),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    ":",
                    style: Get.textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                _timeText(false),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _timeText(bool isHour) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          visualDensity: VisualDensity(vertical: -2),
          icon: Icon(Icons.arrow_drop_up, color: Colors.white, size: 30),
          onPressed: () {
            if (isHour) {
              if (_hour.value == 23) {
                _hour.value = 0;
              } else {
                _hour++;
              }
            } else {
              if (_minute.value == 59) {
                _minute.value = 0;
              } else {
                _minute++;
              }
            }
          },
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: CustomThemeData.primaryColorLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            isHour
                ? _hour.toString().padLeft(2, '0')
                : _minute.toString().padLeft(2, '0'),
            style: Get.textTheme.headlineSmall,
          ),
        ),
        IconButton(
          visualDensity: VisualDensity(vertical: -2),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            if (isHour) {
              if (_hour.value == 0) {
                _hour.value = 23;
              } else {
                _hour--;
              }
            } else {
              if (_minute.value == 0) {
                _minute.value = 59;
              } else {
                _minute--;
              }
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body());
  }
}
