import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/time_controller.dart';
import 'package:my_portfolio/screens/apps/calculator.dart';
import 'package:my_portfolio/screens/apps/notes.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late final TimeController _timeController = Get.find<TimeController>();

  Widget _dateTime() {
    return Column(
      children: [
        Obx(
          () => Text(
            _timeController.timeString,
            style: Get.textTheme.displayLarge?.copyWith(fontSize: 48),
          ),
        ),
        Obx(
          () => Text(
            _timeController.dateString,
            style: Get.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _appButton(String title, IconData icon, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(tag: title, child: Icon(icon, size: 32)),
          const SizedBox(height: 4),
          Flexible(
            child: Text(title, overflow: TextOverflow.ellipsis, maxLines: 1),
          ),
        ],
      ),
    );
  }

  List<Widget> _appsList() {
    return [
      _appButton('Calculator', Icons.calculate, () {
        Get.to(
          () => const CalculatorApp(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      }),
      _appButton('Notes', Icons.notes, () {
        Get.to(
          () => const NoteApp(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      }),
      _appButton('Calendar', Icons.calendar_month, () {
        // Get.to(
        //   () => const CalendarApp(),
        //   transition: Transition.fadeIn,
        //   duration: const Duration(milliseconds: 500),
        // );
      }),
      _appButton('Clock', Icons.punch_clock_outlined, () {
        // Get.to(
        //   () => const ClockApp(),
        //   transition: Transition.fadeIn,
        //   duration: const Duration(milliseconds: 500),
        // );
      }),
      _appButton('Settings', Icons.settings, () {
        // Get.to(
        //   () => const SettingsApp(),
        //   transition: Transition.fadeIn,
        //   duration: const Duration(milliseconds: 500),
        // );
      }),
      _appButton('Weather', Icons.wb_sunny, () {
        // Get.to(
        //   () => const WeatherApp(),
        //   transition: Transition.fadeIn,
        //   duration: const Duration(milliseconds: 500),
        // );
      }),
      _appButton('Music', Icons.music_note, () {
        // Get.to(
        //   () => const MusicApp(),
        //   transition: Transition.fadeIn,
        //   duration: const Duration(milliseconds: 500),
        // );
      }),
    ];
  }

  Widget _apps(double width) {
    int crossAxisCount = width ~/ 75;
    int remainingSpace =
        crossAxisCount % _appsList().length == 0
            ? 0
            : crossAxisCount - (_appsList().length % crossAxisCount);

    List<Widget> gridItems =
        List<Widget>.filled(remainingSpace, const SizedBox.shrink()) +
        _appsList();

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: width ~/ 75,
      childAspectRatio: 1,
      mainAxisSpacing: 25,
      crossAxisSpacing: 10,
      children: gridItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Column(children: [_dateTime(), Spacer(), _apps(Get.width - 10)]),
    );
  }
}
