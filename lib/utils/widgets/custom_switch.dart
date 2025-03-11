import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/theme.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key, required this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.value,
      onChanged: widget.onChanged,
      activeColor: CustomThemeData.primaryColorDark,
      activeTrackColor: CustomThemeData.primaryColorLight,
      inactiveThumbColor: CustomThemeData.secondaryTextColor,
      inactiveTrackColor: CustomThemeData.dividerColor,
      padding: EdgeInsets.zero,
      thumbIcon: WidgetStatePropertyAll(
        Icon(
          widget.value ? Icons.alarm_on : Icons.alarm_off,
          color: Colors.white,
        ),
      ),
    );
  }
}
