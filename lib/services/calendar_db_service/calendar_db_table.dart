import 'package:drift/drift.dart';

class CalendarTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text().withLength(min: 1, max: 50)();
  TextColumn get title => text().withLength(min: 1, max: 50)();
  TextColumn get description => text()();
  DateTimeColumn get time => dateTime()();
}


