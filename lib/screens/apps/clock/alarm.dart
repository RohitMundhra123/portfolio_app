import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/controllers/clock_controller.dart';
import 'package:my_portfolio/utils/widgets/painter/clock_picker_painter.dart';

class AlarmApp extends StatefulWidget {
  const AlarmApp({super.key, required this.clockController});

  final ClockController clockController;

  @override
  State<AlarmApp> createState() => _AlarmAppState();
}

class _AlarmAppState extends State<AlarmApp> {
  late final ClockController _clockController;
  int? selectedHour;
  int? selectedMinute;

  @override
  void initState() {
    super.initState();
    _clockController = widget.clockController;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          _clockController.alarms.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.alarm_off,
                      size: 100,
                      color: CustomThemeData.secondaryTextColor,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'No Alarms Set Yet!!!',
                      style: Get.textTheme.headlineMedium?.copyWith(
                        color: CustomThemeData.secondaryTextColor,
                      ),
                    ),
                    CustomPaint(
                      painter: ClockPickerPainter(
                        selectedHour: selectedHour,
                        selectedMinute: selectedMinute,
                        onTimeChange: (hour) {
                          setState(() {
                            if (hour == 0) {
                              selectedHour = 12;
                            } else {
                              selectedHour = hour;
                            }
                          });
                        },
                      ),
                      size: const Size(200, 200),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: _clockController.alarms.length,
                itemBuilder: (context, index) {
                  final alarm = _clockController.alarms[index];
                  return ListTile(
                    title: Text(alarm.alarmTime.format(context)),
                    subtitle: Text(alarm.description),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _clockController.alarms.removeAt(index);
                      },
                    ),
                  );
                },
              ),
    );
  }
}
