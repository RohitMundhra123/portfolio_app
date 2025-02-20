class NotesModel {
  final int id;
  final String title;
  final String content;
  final String date;

  NotesModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'content': content, 'date': date};
  }
}
