import 'package:drift/drift.dart';
import 'package:my_portfolio/models/calendar_model.dart';
import 'package:my_portfolio/services/calendar_db_service/calendar_db.dart';

class CalendarDbServices {
  static final CalendarDbServices _instance = CalendarDbServices._internal();
  factory CalendarDbServices() => _instance;
  CalendarDbServices._internal();

  final db = CalendarDatabase();

  Future<void> addEvent(
    String date,
    String title,
    String description,
    DateTime time,
  ) async {
    await db
        .into(db.calendarTable)
        .insert(
          CalendarTableCompanion.insert(
            date: date,
            title: title,
            description: description,
            time: time,
          ),
        );
  }

  Future<List<CalendarModel>> getEvent() async {
    final event = await db.select(db.calendarTable).get();

    return event
        .map(
          (e) => CalendarModel(
            id: e.id,
            date: e.date,
            title: e.title,
            description: e.description,
            time: e.time,
          ),
        )
        .toList();
  }

  Future<List<CalendarModel>> getEventByDate(String date) async {
    final event =
        await (db.select(db.calendarTable)
          ..where((tbl) => tbl.date.equals(date))).get();

    return event
        .map(
          (e) => CalendarModel(
            id: e.id,
            date: e.date,
            title: e.title,
            description: e.description,
            time: e.time,
          ),
        )
        .toList();
  }

  Future<void> updateEvent(CalendarModel event) async {
    await (db.update(db.calendarTable)
      ..where((tbl) => tbl.id.equals(event.id))).write(
      CalendarTableCompanion(
        id: Value(event.id),
        date: Value(event.date),
        title: Value(event.title),
        description: Value(event.description),
        time: Value(event.time),
      ),
    );
  }

  Future<void> deleteEvent(int id) async {
    await (db.delete(db.calendarTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
