import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/models/calendar_model.dart';
import 'package:my_portfolio/services/calendar_db_service/calendar_db_services.dart';

class YearRange {
  int startYear;
  int endYear;

  YearRange({required this.startYear, required this.endYear});

  factory YearRange.fromJson(Map<String, dynamic> json) {
    return YearRange(startYear: json['startYear'], endYear: json['endYear']);
  }

  Map<String, dynamic> toJson() {
    return {'startYear': startYear, 'endYear': endYear};
  }
}

class CalendarController extends GetxController {
  late final RxInt year;
  late final RxInt month;
  late final RxInt day;
  late final RxInt selectedDay;
  late final RxInt selectedMonth;
  late final RxInt selectedYear;
  late final Rx<YearRange> yearRange;
  late final List<YearRange> yearRanges = [];
  RxList<CalendarModel> events = <CalendarModel>[].obs;

  final ScrollController monthScrollController = ScrollController();
  final PageController yearPageController = PageController();

  final CalendarDbServices _calendarDbServices = CalendarDbServices();

  String get formatDateForDb =>
      '${selectedYear.value}-${selectedMonth.value}-${selectedDay.value}';

  @override
  void onInit() {
    year = DateTime.now().year.obs;
    month = DateTime.now().month.obs;
    day = DateTime.now().day.obs;
    selectedYear = DateTime.now().year.obs;
    selectedMonth = DateTime.now().month.obs;
    selectedDay = DateTime.now().day.obs;
    getCurrentYearRange();
    yearPageController.addListener(() {
      final int currentPage = yearPageController.page?.round() ?? 0;
      yearRange.value = yearRanges[currentPage];
    });
    selectedYear.listen((value) {
      yearRange.value = yearRanges.firstWhere(
        (range) => range.startYear <= value && range.endYear >= value,
      );
    });
    super.onInit();
  }

  getCurrentYearRange() {
    final startYear = DateTime.now().year - 50;
    final endYear = DateTime.now().year + 50;

    final int totalYears = endYear - startYear;
    final int yearRangeIndex = totalYears ~/ 9;

    for (int i = 0; i <= yearRangeIndex; i++) {
      int start = startYear + (i * 9);
      int end = (i == yearRangeIndex) ? endYear : start + 8;
      yearRanges.add(YearRange(startYear: start, endYear: end));
    }
    yearRange =
        yearRanges
            .firstWhere(
              (range) =>
                  range.startYear <= year.value && range.endYear >= year.value,
            )
            .obs;
  }

  void refreshUpdate() {
    selectedYear.value = DateTime.now().year;
    selectedMonth.value = DateTime.now().month;
    selectedDay.value = DateTime.now().day;
    monthScrollController.jumpTo((selectedMonth.value - 1) * 75.0);
  }

  void incrementRange(bool increase) {
    final int currentIndex = yearRanges.indexOf(yearRange.value);
    if ((currentIndex == 0 && !increase) ||
        (currentIndex == yearRanges.length - 1 && increase)) {
      return;
    }
    if (increase) {
      yearPageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      yearPageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void incrementYear(bool increase) {
    if ((selectedYear.value == (year.value - 50)) && !increase) return;
    if (selectedYear.value == (year.value + 50) && increase) return;
    if (increase) {
      selectedYear.value++;
    } else {
      selectedYear.value--;
    }
    if (selectedYear.value == year.value &&
        selectedMonth.value == month.value) {
      selectedDay.value = day.value;
    } else {
      selectedDay.value = 1;
    }
  }

  void changeMonth(int newMonth) {
    selectedMonth.value = newMonth;
    if (selectedMonth.value == month.value &&
        selectedYear.value == year.value) {
      selectedDay.value = day.value;
    } else {
      selectedDay.value = 1;
    }
  }

  bool isToday(int sday) {
    return selectedYear.value == year.value &&
        selectedMonth.value == month.value &&
        sday == day.value;
  }

  int getDaysInMonth() {
    return DateTime(selectedYear.value, selectedMonth.value + 1, 0).day;
  }

  int getgap() {
    return DateTime(selectedYear.value, selectedMonth.value, 1).weekday;
  }

  int getCountofGrid() {
    return getDaysInMonth() + getgap() - 1;
  }

  addEvent(String date, String title, String description, DateTime time) async {
    await _calendarDbServices.addEvent(date, title, description, time);
  }

  getEvent() async {
    events.value = await _calendarDbServices.getEventByDate(formatDateForDb);
  }

  updateEvent(CalendarModel event) async {
    await _calendarDbServices.updateEvent(event);
  }

  deleteEvent(int id) async {
    await _calendarDbServices.deleteEvent(id);
  }
}
