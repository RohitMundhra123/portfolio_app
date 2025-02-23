import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_portfolio/services/calendar_db_service/calendar_db_table.dart';

part 'calendar_db.g.dart';

@DriftDatabase(tables: [CalendarTable])
class CalendarDatabase extends _$CalendarDatabase {
  CalendarDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'calendar.db',
      native: DriftNativeOptions(
        databaseDirectory: () => getApplicationDocumentsDirectory(),
      ),
    );
  }
}
