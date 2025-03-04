import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/controllers/clock_controller.dart';
import 'package:my_portfolio/models/alarm_model.dart';
import 'package:my_portfolio/utils/widgets/custom_snackbar.dart';
import 'package:my_portfolio/utils/widgets/textformfield/content_textformfield.dart';

class AddAlarm extends StatefulWidget {
  const AddAlarm({super.key, required this.clockController});

  final ClockController clockController;

  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  TimeOfDay? _alarmTimeData;
  late final ClockController _clockController;

  @override
  void initState() {
    super.initState();
    _clockController = widget.clockController;
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
    return Column(
      children: [_alarmTime(), const SizedBox(height: 15), _description()],
    );
  }

  final TextEditingController titleController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();

  Widget _description() {
    return ContentTextformfield(
      contentController: titleController,
      focusNode: titleFocusNode,
      hintText: 'Title',
    );
  }

  Widget _alarmTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Alarm Time',
              style: Get.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final res = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (res != null) {
                setState(() {
                  _alarmTimeData = res;
                });
              }
            },
            child:
                (_alarmTimeData != null)
                    ? Text(
                      '${_alarmTimeData!.hour.toString().padLeft(2, '0')}:${_alarmTimeData!.minute.toString().padLeft(2, '0')}',
                    )
                    : const Text('Select Time'),
          ),
        ],
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
            if (_alarmTimeData == null) {
              CustomSnackBar(
                message: 'Please select a time',
                title: 'Error',
                icon: Icons.error,
              ).show();
              return;
            } else if (titleController.text.isEmpty) {
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
                  alarmTime: _alarmTimeData!,
                  description: titleController.text,
                  isActive: true,
                ),
              );
              Get.back();
              CustomSnackBar(
                message: 'Alarm Added for ${_alarmTimeData!.format(context)}',
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
