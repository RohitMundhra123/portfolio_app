import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/controllers/clock_controller.dart';
import 'package:my_portfolio/models/alarm_model.dart';
import 'package:my_portfolio/utils/widgets/custom_snackbar.dart';
import 'package:my_portfolio/utils/widgets/painter/minute_picker_painter.dart';
import 'package:my_portfolio/utils/widgets/textformfield/content_textformfield.dart';

class AddAlarm extends StatefulWidget {
  const AddAlarm({super.key, required this.clockController});

  final ClockController clockController;

  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  late final ClockController _clockController;

  @override
  void initState() {
    super.initState();
    _clockController = widget.clockController;
    titleFocusNode.requestFocus();
    titleController.text = 'Work';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (titleFocusNode.hasFocus) {
          titleFocusNode.unfocus();
        } else {
          titleFocusNode.requestFocus();
        }
      },
      child: Container(
        height: Get.height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.vertical(
            top: Radius.circular(25),
          ),
          border: Border(
            top: BorderSide(color: CustomThemeData.primaryColor, width: 2),
          ),
          color: CustomThemeData.primaryColorLight,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _heading(),
        Divider(
          color: CustomThemeData.primaryTextColor,
          thickness: 1,
          height: 20,
        ),
        _form(),
      ],
    );
  }

  Widget _form() {
    return Column(children: [_alarmTimePicker(), _description()]);
  }

  final TextEditingController titleController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ContentTextformfield(
        contentController: titleController,
        focusNode: titleFocusNode,
        dialog: true,
        hintText: 'Title',
      ),
    );
  }

  Widget _alarmTimePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Obx(
        () => Column(
          children: [
            _alarmTime(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaint(
                  painter:
                  // HourPickerPainter(
                  //   selectedHour:
                  //       _clockController.alarmTime.value.hour % 12 == 0
                  //           ? 12
                  //           : _clockController.alarmTime.value.hour % 12,
                  //   onTimeChange: (hour) {
                  //     _clockController.alarmTime.value = TimeOfDay(
                  //       hour:
                  //           _clockController.alarmIsAm.value ? hour : hour + 12,
                  //       minute: _clockController.alarmTime.value.minute,
                  //     );
                  //   },
                  // ),
                  MinutePickerPainter(
                    selectedMinute: _clockController.alarmTime.value.minute,
                    onTimeChange: (minute) {
                      _clockController.alarmTime.value = TimeOfDay(
                        hour: _clockController.alarmTime.value.hour,
                        minute: minute,
                      );
                    },
                  ),
                  size: const Size(200, 200),
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _clockController.alarmIsAm.value = true;
                        _clockController.alarmTime.value.period == DayPeriod.am
                            ? _clockController.alarmTime.value
                            : _clockController.alarmTime.value = TimeOfDay(
                              hour: _clockController.alarmTime.value.hour - 12,
                              minute: _clockController.alarmTime.value.minute,
                            );
                      },
                      child: _amPmTile(true),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _clockController.alarmIsAm.value = false;
                        _clockController.alarmTime.value.period == DayPeriod.pm
                            ? _clockController.alarmTime.value
                            : _clockController.alarmTime.value = TimeOfDay(
                              hour: _clockController.alarmTime.value.hour + 12,
                              minute: _clockController.alarmTime.value.minute,
                            );
                      },
                      child: _amPmTile(false),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _alarmTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timeTile(_clockController.alarmTime.value.hour),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(':', style: Get.textTheme.headlineSmall),
        ),
        _timeTile(_clockController.alarmTime.value.minute),
      ],
    );
  }

  Widget _amPmTile(bool isAm) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color:
            isAm == _clockController.alarmIsAm.value
                ? CustomThemeData.primaryColor
                : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isAm ? 'AM' : 'PM',
        style: Get.textTheme.titleSmall?.copyWith(
          color:
              isAm == _clockController.alarmIsAm.value
                  ? Colors.white
                  : Colors.black,
          fontWeight: FontWeight.w600,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
    );
  }

  Widget _timeTile(int time) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: CustomThemeData.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        time.toString().padLeft(2, '0'),
        style: Get.textTheme.headlineMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
    );
  }

  Widget _heading() {
    return Row(
      children: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Get.back();
          },
        ),
        Expanded(
          child: Text(
            'Add Alarm',
            style: Get.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            if (titleController.text.isEmpty) {
              CustomSnackBar(
                message: 'Please enter a Title',
                title: 'Error',
                icon: Icons.error,
              ).show();
              return;
            } else {
              _clockController.addAlarm(
                AlarmModel(
                  id:
                      DateTime.fromMicrosecondsSinceEpoch(
                        DateTime.now().microsecondsSinceEpoch,
                      ).toString(),
                  alarmTime: _clockController.alarmTime.value,
                  description: titleController.text,
                  isActive: true,
                ),
              );
              Get.back();
              CustomSnackBar(
                message:
                    'Alarm Added for ${_clockController.alarmTime.value.format(context)}',
                title: 'Success',
                icon: Icons.check_circle,
              ).show();
            }
          },
        ),
      ],
    );
  }
}
