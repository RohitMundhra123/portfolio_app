import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/controllers/clock_controller.dart';

class StopwatchApp extends StatefulWidget {
  const StopwatchApp({super.key, required this.clockController});

  final ClockController clockController;

  @override
  State<StopwatchApp> createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _playPauseAnimationController;
  late Animation<double> _playPauseAnimation;
  late ClockController _clockController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _playPauseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _clockController = widget.clockController;
    _playPauseAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(_playPauseAnimationController);
  }

  playPauseAnimation() {
    if (_playPauseAnimationController.isCompleted) {
      _playPauseAnimationController.reverse();
      _clockController.pauseStopWatch();
    } else {
      _playPauseAnimationController.forward();
      _clockController.startStopWatch();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_stopWatch(), Flexible(child: _timeLapslistView())],
              ),
            ),
            _buttons(),
          ],
        ),
      ),
    );
  }

  Widget _timeLapslistView() {
    return Obx(
      () => ListView.separated(
        itemCount: _clockController.stopWatchLaps.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return const Divider(
            height: 20,
            color: CustomThemeData.dividerColor,
            thickness: 1,
          );
        },
        reverse: true,
        itemBuilder: (context, index) {
          return _timeLapsTile(index);
        },
      ),
    );
  }

  Widget _timeLapsTile(int index) {
    return Row(
      children: [
        Icon(Icons.flag, color: Colors.black),
        const SizedBox(width: 10),
        SizedBox(
          width: 35,
          child: Text(
            '${index + 1}',
            style: Get.textTheme.titleLarge?.copyWith(
              fontFamily: "Monospace",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Spacer(),
        Text(
          _clockController.stopWatchLaps[index],
          style: Get.textTheme.titleLarge?.copyWith(
            fontFamily: "Monospace",

            color: CustomThemeData.primaryColorDark,
          ),
        ),
      ],
    );
  }

  Widget _stopWatch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: _clockText()),
                if (_clockController.stopWatchShowButtons.value)
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: CustomThemeData.primaryColorLight,
                      border: Border.all(
                        color: CustomThemeData.primaryColorDark,
                        width: 2,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 20),

                    child: Center(
                      child: _timeText(
                        (_clockController.stopWatchMilliseconds.value)
                            .floor()
                            .toString()
                            .padLeft(2, '0'),
                        fontSize: 24,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _clockText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _timeText(
          _clockController.stopWatchHours.value.toString().padLeft(2, '0'),
        ),
        _semiColon(),
        _timeText(
          _clockController.stopWatchMinutes.value.toString().padLeft(2, '0'),
        ),
        _semiColon(),
        _timeText(
          _clockController.stopWatchSeconds.value.toString().padLeft(2, '0'),
        ),
      ],
    );
  }

  Widget _semiColon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: const Text(
        ':',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _timeText(text, {double fontSize = 42}) {
    return Text(
      text,
      style: Get.textTheme.headlineLarge?.copyWith(fontSize: fontSize),
    );
  }

  Widget _buttons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: Get.width,
        child: Obx(
          () => Stack(
            clipBehavior: Clip.none,
            children: [_reset(), _flag(), _playPause()],
          ),
        ),
      ),
    );
  }

  Widget _reset() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: _clockController.stopWatchShowButtons.value ? 150 : 0,
      top: 0,
      bottom: 0,
      right: 0,
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          _playPauseAnimationController.reverse();
          _clockController.resetStopWatch();
        },
        icon: _buttonTile(Icon(Icons.undo, color: Colors.white, size: 24)),
      ),
    );
  }

  Widget _flag() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      right: _clockController.stopWatchShowButtons.value ? 150 : 0,
      left: 0,
      top: 0,
      bottom: 0,
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          _clockController.setFlag();
        },
        icon: _buttonTile(Icon(Icons.flag, color: Colors.white, size: 24)),
      ),
    );
  }

  Widget _playPause() {
    return Center(
      child: IconButton(
        onPressed: () {
          playPauseAnimation();
        },
        icon: _buttonTile(
          AnimatedIcon(
            icon: AnimatedIcons.pause_play,
            progress: _playPauseAnimation,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),
    );
  }

  Widget _buttonTile(icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Get.theme.primaryColor,
      ),
      child: icon,
    );
  }
}
