import 'package:flutter/material.dart';

AppBar customAppBar(String title) {
  return AppBar(
    leading: Hero(tag: title, child: Icon(getIcon(title), size: 36)),
    title: Text(title),
    automaticallyImplyLeading: false,
  );
}

IconData getIcon(String title) {
  if (title == 'Notes') {
    return Icons.notes;
  } else if (title == 'Calculator') {
    return Icons.calculate;
  } else if (title == 'Weather') {
    return Icons.wb_sunny;
  } else if (title == 'Settings') {
    return Icons.settings;
  } else if (title == 'Clock') {
    return Icons.punch_clock_outlined;
  } else if (title == 'Calendar') {
    return Icons.calendar_month;
  } else if (title == 'Music') {
    return Icons.music_note;
  } else {
    return Icons.error;
  }
}
