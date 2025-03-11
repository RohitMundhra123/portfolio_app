import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/controllers/clock_controller.dart';
import 'package:my_portfolio/models/alarm_model.dart';

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
                : ListView.builder(
                  itemCount: _clockController.alarms.length,
                  itemBuilder: (context, index) {
                    return _alarmTile(_clockController.alarms[index]);
                  },
                ),
      ),
    );
  }

  Widget _alarmTile(AlarmModel alarm) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color:
            alarm.isActive
                ? CustomThemeData.accentColor
                : CustomThemeData.primaryColorLight,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                alarm.description,
                style: Get.textTheme.headlineSmall?.copyWith(
                  color:
                      alarm.isActive
                          ? Colors.white
                          : CustomThemeData.secondaryTextColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${alarm.alarmTime.hour}:${alarm.alarmTime.minute} ${alarm.alarmTime.period == DayPeriod.am ? 'AM' : 'PM'}',
                style: Get.textTheme.headlineMedium?.copyWith(
                  color:
                      alarm.isActive
                          ? Colors.white
                          : CustomThemeData.secondaryTextColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const Spacer(),
          Switch(
            value: alarm.isActive,
            onChanged: (value) {
              _clockController.toogleAlarm(alarm);
              _clockController.alarms.refresh();
            },
          ),
        ],
      ),
    );
  }
}
