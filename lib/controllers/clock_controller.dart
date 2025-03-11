import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/models/alarm_model.dart';
import 'package:my_portfolio/services/shared_preferences_service.dart';

class ClockController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  final RxBool stopWatchShowButtons = false.obs;
  final RxInt stopWatchHours = 0.obs;
  final RxInt stopWatchMinutes = 0.obs;
  final RxInt stopWatchSeconds = 0.obs;
  final RxInt stopWatchMilliseconds = 0.obs;
  final RxList<String> stopWatchLaps = <String>[].obs;
  final RxList<AlarmModel> alarms = <AlarmModel>[].obs;
  final RxList<AlarmModel> selectedAlarms = <AlarmModel>[].obs;
  final RxBool isHourSelected = true.obs;

  final Rx<TimeOfDay> alarmTime = TimeOfDay.now().obs;
  final RxBool alarmIsAm = true.obs;

  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  @override
  void onInit() {
    super.onInit();
    initializeSharedPrefs();
  }

  initializeSharedPrefs() async {
    await _sharedPreferencesService.init();
    _sharedPreferencesService
        .getStringList(SharedPreferencesService.stopWatchLaps)
        ?.forEach((element) {
          stopWatchLaps.add(element);
        });
    final time = _sharedPreferencesService.getString(
      SharedPreferencesService.stopWatchTime,
    );
    if (time != null) {
      final timeSplit = time.split(':');
      stopWatchHours.value = int.parse(timeSplit[0]);
      stopWatchMinutes.value = int.parse(timeSplit[1]);
      final secondsSplit = timeSplit[2].split('.');
      stopWatchSeconds.value = int.parse(secondsSplit[0]);
      stopWatchMilliseconds.value = int.parse(secondsSplit[1]);
      if (stopWatchHours.value > 0 ||
          stopWatchMinutes.value > 0 ||
          stopWatchSeconds.value > 0 ||
          stopWatchMilliseconds.value > 0 ||
          stopWatchLaps.isNotEmpty) {
        stopWatchShowButtons.value = true;
      }
    }
    _sharedPreferencesService
        .getStringList(SharedPreferencesService.alarms)
        ?.forEach((element) {
          final alarm = AlarmModel.fromMap(jsonDecode(element));
          alarms.add(alarm);
        });
  }

  void pageChange() {
    pageController.animateToPage(
      currentIndex.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Timer? _stopWatchTimer;

  void startStopWatch() {
    stopWatchShowButtons.value = true;
    _stopWatchTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      stopWatchMilliseconds.value++;
      if (stopWatchMilliseconds.value == 100) {
        stopWatchMilliseconds.value = 0;
        stopWatchSeconds.value++;
      }
      if (stopWatchSeconds.value == 60) {
        stopWatchSeconds.value = 0;
        stopWatchMinutes.value++;
      }
      if (stopWatchMinutes.value == 60) {
        stopWatchMinutes.value = 0;
        stopWatchHours.value++;
      }
    });
  }

  void pauseStopWatch() {
    _stopWatchTimer?.cancel();
  }

  void resetStopWatch() {
    _stopWatchTimer?.cancel();
    stopWatchShowButtons.value = false;
    stopWatchHours.value = 0;
    stopWatchMinutes.value = 0;
    stopWatchSeconds.value = 0;
    stopWatchMilliseconds.value = 0;
    stopWatchLaps.clear();
    _sharedPreferencesService.setStringList(
      SharedPreferencesService.stopWatchLaps,
      stopWatchLaps,
    );
  }

  void setFlag() {
    stopWatchLaps.add(
      '${stopWatchHours.value > 0 ? '${stopWatchHours.value.toString().padLeft(2, '0')}:' : ''}'
      '${stopWatchMinutes.value.toString().padLeft(2, '0')}:'
      '${stopWatchSeconds.value.toString().padLeft(2, '0')}.'
      '${stopWatchMilliseconds.value.toString().padLeft(2, '0')}',
    );
    _sharedPreferencesService.setStringList(
      SharedPreferencesService.stopWatchLaps,
      stopWatchLaps,
    );
  }

  void backPageInvoked() {
    _sharedPreferencesService.setString(
      SharedPreferencesService.stopWatchTime,
      '${stopWatchHours.value.toString().padLeft(2, '0')}:'
      '${stopWatchMinutes.value.toString().padLeft(2, '0')}:'
      '${stopWatchSeconds.value.toString().padLeft(2, '0')}.'
      '${stopWatchMilliseconds.value.toString().padLeft(2, '0')}',
    );
  }

  void addAlarm(AlarmModel alarm) {
    alarms.add(alarm);
    _sharedPreferencesService.setStringList(
      SharedPreferencesService.alarms,
      alarms.map((e) => jsonEncode(e.toMap())).toList(),
    );
  }

  void deleteAlarms() {
    alarms.removeWhere((element) => selectedAlarms.contains(element));
    selectedAlarms.clear();
    alarms.refresh();
    _sharedPreferencesService.setStringList(
      SharedPreferencesService.alarms,
      alarms.map((e) => jsonEncode(e.toMap())).toList(),
    );
  }

  void toogleAlarm(AlarmModel alarm) {
    alarm.isActive = !alarm.isActive;
    _sharedPreferencesService.setStringList(
      SharedPreferencesService.alarms,
      alarms.map((e) => jsonEncode(e.toMap())).toList(),
    );
  }

  void updateAlarm(AlarmModel alarm) {
    _sharedPreferencesService.setStringList(
      SharedPreferencesService.alarms,
      alarms.map((e) => jsonEncode(e.toMap())).toList(),
    );
  }

  void onLongTapAlarm(AlarmModel alarm) {
    if (selectedAlarms.contains(alarm)) {
      selectedAlarms.remove(alarm);
    } else {
      selectedAlarms.add(alarm);
    }
  }

  void onTapAlarm(AlarmModel alarm) {
    if (selectedAlarms.isNotEmpty) {
      onLongTapAlarm(alarm);
    } else {}
  }
}
