import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/clock_controller.dart';
import 'package:my_portfolio/screens/apps/clock/stopwatch.dart';
import 'package:my_portfolio/utils/widgets/appbar_widget.dart';

class ClockApp extends StatefulWidget {
  const ClockApp({super.key});

  @override
  State<ClockApp> createState() => _ClockAppState();
}

class _ClockAppState extends State<ClockApp> {
  final ClockController _clockController = Get.put(ClockController());

  Widget _body() {
    return PageView.builder(
      controller: _clockController.pageController,
      itemCount: 3,

      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Container();
          case 1:
            return Container();
          case 2:
            return StopwatchApp(clockController: _clockController);
          default:
            return Container();
        }
      },
    );
  }

  Widget _bottomNavigationBar() {
    return SafeArea(
      child: Obx(
        () => BottomNavigationBar(
          elevation: 0,
          currentIndex: _clockController.currentIndex.value,
          onTap: (index) {
            _clockController.currentIndex.value = index;
            _clockController.pageChange();
          },
          items: [
            _bottomNavigationBarItem(
              _clockController.currentIndex.value == 0
                  ? Icons.access_time_filled
                  : Icons.access_time_outlined,
              'Clock',
            ),
            _bottomNavigationBarItem(
              _clockController.currentIndex.value == 1
                  ? Icons.alarm_add
                  : Icons.alarm,
              'Alarm',
            ),
            _bottomNavigationBarItem(
              _clockController.currentIndex.value == 2
                  ? Icons.timer
                  : Icons.timer_outlined,
              'Stopwatch',
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
    IconData icon,
    String label,
  ) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Clock'),
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
