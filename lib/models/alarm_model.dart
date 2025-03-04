import 'package:flutter/material.dart';

class AlarmModel {
  String id;
  TimeOfDay alarmTime;
  String description;
  bool isActive;

  AlarmModel({
    required this.id,
    required this.alarmTime,
    required this.description,
    required this.isActive,
  });

  factory AlarmModel.fromMap(Map<String, dynamic> json) => AlarmModel(
    id: json["id"],
    alarmTime: TimeOfDay(
      hour: json["alarmTime"]["hour"],
      minute: json["alarmTime"]["minute"],
    ),
    description: json["description"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "description": description,
    "alarmTime": {"hour": alarmTime.hour, "minute": alarmTime.minute},
    "isActive": isActive,
  };
}
