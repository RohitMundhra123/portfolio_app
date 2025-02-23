import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/controllers/calendar_controller.dart';
import 'package:my_portfolio/utils/date.dart';
import 'package:my_portfolio/utils/widgets/appbar_widget.dart';

class CalendarApp extends StatefulWidget {
  const CalendarApp({super.key});

  @override
  State<CalendarApp> createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  final CalendarController _calendarController = Get.put(CalendarController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _calendarController.monthScrollController.jumpTo(
        (_calendarController.selectedMonth.value - 1) * 75.0,
      );
    });
  }

  Widget _body() {
    return RefreshIndicator(
      onRefresh: () async {
        _calendarController.refreshUpdate();
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            spacing: 20,
            children: [
              _yearContainer(),
              _monthContainer(),
              _weekanddayContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _yearContainer() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => _calendarController.incrementYear(false),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color:
                  _calendarController.selectedYear.value <=
                          _calendarController.year.value - 50
                      ? Colors.grey
                      : Get.theme.primaryColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.dialog(_yearDialogWidget());
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _calendarController.yearPageController.jumpToPage(
                  _calendarController.yearRanges.indexOf(
                    _calendarController.yearRange.value,
                  ),
                );
              });
            },
            child: Text(
              _calendarController.selectedYear.value.toString(),
              style: Get.textTheme.headlineMedium?.copyWith(
                color: CustomThemeData.primaryColorDark,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          IconButton(
            onPressed: () => _calendarController.incrementYear(true),
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color:
                  _calendarController.selectedYear.value >=
                          _calendarController.year.value + 25
                      ? Colors.grey
                      : Get.theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _monthContainer() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: 12,
        controller: _calendarController.monthScrollController,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return _monthTile(index);
        },
      ),
    );
  }

  Widget _weekanddayContainer() {
    return Container(
      decoration: BoxDecoration(
        color: CustomThemeData.primaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(children: [_weekContainer(), _dayContainer()]),
    );
  }

  Widget _weekContainer() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.2,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 7,
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            DateHelper.weekInitials(index + 1),
            style: Get.textTheme.headlineSmall?.copyWith(
              color: CustomThemeData.primaryColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        );
      },
    );
  }

  Widget _dayContainer() {
    return Obx(
      () => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _calendarController.getCountofGrid(),
        itemBuilder: (context, index) {
          if (index < _calendarController.getgap() - 1) {
            return const SizedBox();
          } else {
            return GestureDetector(
              onTap: () {
                _calendarController.selectedDay.value =
                    index - _calendarController.getgap() + 2;
              },
              child: _dateTile(index - _calendarController.getgap() + 1),
            );
          }
        },
      ),
    );
  }

  Widget _dateTile(index) {
    return Obx(
      () => Center(
        child: CircleAvatar(
          backgroundColor:
              _calendarController.isToday(index + 1)
                  ? CustomThemeData.primaryColorDark
                  : _calendarController.selectedDay.value == index + 1
                  ? CustomThemeData.secondaryTextColor
                  : Colors.transparent,
          child: Text(
            (index + 1).toString(),
            style: Get.textTheme.titleMedium?.copyWith(
              fontWeight:
                  _calendarController.isToday(index + 1)
                      ? FontWeight.w700
                      : _calendarController.selectedDay.value == index + 1
                      ? FontWeight.w700
                      : FontWeight.w500,
              color:
                  _calendarController.isToday(index + 1)
                      ? Get.theme.colorScheme.onPrimary
                      : _calendarController.selectedDay.value == index + 1
                      ? Colors.white70
                      : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _monthTile(index) {
    return GestureDetector(
      onTap: () => _calendarController.changeMonth(index + 1),
      child: Obx(
        () => Container(
          width: 65,
          decoration: BoxDecoration(
            color:
                _calendarController.selectedMonth.value == index + 1
                    ? Get.theme.primaryColor
                    : null,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Get.theme.primaryColor, width: 1),
          ),

          child: Center(
            child: Text(
              DateHelper.getHalfMonthName(index + 1),
              style: Get.textTheme.titleLarge?.copyWith(
                color:
                    _calendarController.selectedMonth.value == index + 1
                        ? Get.theme.colorScheme.onPrimary
                        : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _yearDialogWidget() {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      backgroundColor: Colors.black,
      title: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => _calendarController.incrementRange(false),
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            Text(
              '${_calendarController.yearRange.value.startYear} - ${_calendarController.yearRange.value.endYear}',
              style: Get.textTheme.headlineSmall?.copyWith(
                color: CustomThemeData.primaryColorDark,
                fontWeight: FontWeight.w900,
              ),
            ),
            IconButton(
              onPressed: () => _calendarController.incrementRange(true),
              icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          ],
        ),
      ),
      content: SizedBox(
        width: Get.width * 0.75,
        height: (Get.width * 0.75) / 1.25,
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: _calendarController.yearPageController,
          itemCount: _calendarController.yearRanges.length,
          itemBuilder: (context, index) {
            return _yearDialogGridView(
              _calendarController.yearRanges[index].startYear,
              _calendarController.yearRanges[index].endYear,
            );
          },
        ),
      ),
    );
  }

  Widget _yearDialogGridView(int start, int end) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1.5,
      ),
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shrinkWrap: true,
      itemCount: end - start + 1,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _calendarController.selectedYear.value = start + index;
            Get.back();
          },
          child: _yearGridTile(start, end, index),
        );
      },
    );
  }

  Widget _yearGridTile(start, end, index) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color:
              _calendarController.selectedYear.value == (start + index)
                  ? Get.theme.primaryColor
                  : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Get.theme.primaryColor, width: 1),
        ),
        child: Center(
          child: Text(
            (start + index).toString(),
            style: Get.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color:
                  _calendarController.selectedYear.value == (start + index)
                      ? Get.theme.colorScheme.onPrimary
                      : null,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Calendar'),
      body: SafeArea(child: _body()),
    );
  }
}
