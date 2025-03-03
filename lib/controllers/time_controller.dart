import 'package:get/get.dart';
import 'package:my_portfolio/utils/date.dart';

class TimeController extends GetxController {
  var currentTime = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    updateTime();
  }

  void updateTime() {
    var now = DateTime.now();
    var nextUpdate = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute + 1,
    );
    var secondsRemaining = nextUpdate.difference(now).inMilliseconds / 1000;

    Future.delayed(Duration(milliseconds: (secondsRemaining).toInt()), () {
      currentTime.value = DateTime.now();
      updateTime();
    });
  }

  int get hour => currentTime.value.hour;
  int get minute => currentTime.value.minute;
  int get second => currentTime.value.second;
  String get fulltimeString =>
      '${currentTime.value.hour.toString().padLeft(2, '0')} : ${currentTime.value.minute.toString().padLeft(2, '0')} : ${currentTime.value.second.toString().padLeft(2, '0')}';
  String get timeString =>
      '${currentTime.value.hour.toString().padLeft(2, '0')} : ${currentTime.value.minute.toString().padLeft(2, '0')}';
  String get dateNum =>
      '${currentTime.value.day.toString().padLeft(2, '0')} / ${currentTime.value.month.toString().padLeft(2, '0')} / ${currentTime.value.year}';
  String get dateString =>
      '${currentTime.value.day.toString().padLeft(2, '0')} ${DateHelper.getMonthName(currentTime.value.month)}, ${currentTime.value.year}';
}
