class CalendarModel {
  final int id;
  String date;
  String title;
  String description;
  DateTime time;

  CalendarModel({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.time,
  });

  factory CalendarModel.fromMap(Map<String, dynamic> json) => CalendarModel(
    id: json['id'],
    date: json['date'],
    title: json['title'],
    description: json['description'],
    time: DateTime.parse(json['time']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'date': date,
    'title': title,
    'description': description,
    'time': time.toIso8601String(),
  };
}
