import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/controllers/clock_controller.dart';
import 'package:my_portfolio/models/alarm_model.dart';
import 'package:my_portfolio/utils/widgets/custom_switch.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Obx(
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
                    ],
                  ),
                )
                : ListView.separated(
                  itemCount: _clockController.alarms.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                  itemBuilder: (context, index) {
                    return _alarmTile(_clockController.alarms[index]);
                  },
                ),
      ),
    );
  }

  Widget _alarmTile(AlarmModel alarm) {
    return GestureDetector(
      onTap: () => _clockController.onTapAlarm(alarm),
      onLongPress: () => _clockController.onLongTapAlarm(alarm),
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color:
                _clockController.selectedAlarms.contains(alarm)
                    ? Colors.red
                    : alarm.isActive
                    ? CustomThemeData.accentColor
                    : CustomThemeData.primaryColorLight,
            borderRadius:
                _clockController.selectedAlarms.contains(alarm)
                    ? BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )
                    : BorderRadius.circular(20),
          ),
          margin:
              _clockController.selectedAlarms.contains(alarm)
                  ? const EdgeInsets.symmetric(horizontal: 15)
                  : EdgeInsets.all(0),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alarm.description,
                    style: Get.textTheme.headlineSmall?.copyWith(
                      color:
                          _clockController.selectedAlarms.contains(alarm)
                              ? Colors.white
                              : alarm.isActive
                              ? Colors.white
                              : CustomThemeData.secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${alarm.alarmTime.hour.toString().padLeft(2, '0')}:${alarm.alarmTime.minute.toString().padLeft(2, '0')} ${alarm.alarmTime.period == DayPeriod.am ? 'AM' : 'PM'}',
                    style: Get.textTheme.headlineMedium?.copyWith(
                      color:
                          _clockController.selectedAlarms.contains(alarm)
                              ? Colors.white
                              : alarm.isActive
                              ? Colors.white
                              : CustomThemeData.secondaryTextColor,
                      fontWeight: FontWeight.w900,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CustomSwitch(
                value: alarm.isActive,
                onChanged: (value) {
                  _clockController.toogleAlarm(alarm);
                  _clockController.alarms.refresh();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
