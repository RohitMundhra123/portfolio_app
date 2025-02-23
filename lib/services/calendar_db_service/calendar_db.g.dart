// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_db.dart';

// ignore_for_file: type=lint
class $CalendarTableTable extends CalendarTable
    with TableInfo<$CalendarTableTable, CalendarTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalendarTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, title, description, time];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calendar_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalendarTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CalendarTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalendarTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}date'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      time:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}time'],
          )!,
    );
  }

  @override
  $CalendarTableTable createAlias(String alias) {
    return $CalendarTableTable(attachedDatabase, alias);
  }
}

class CalendarTableData extends DataClass
    implements Insertable<CalendarTableData> {
  final int id;
  final String date;
  final String title;
  final String description;
  final DateTime time;
  const CalendarTableData({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.time,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['time'] = Variable<DateTime>(time);
    return map;
  }

  CalendarTableCompanion toCompanion(bool nullToAbsent) {
    return CalendarTableCompanion(
      id: Value(id),
      date: Value(date),
      title: Value(title),
      description: Value(description),
      time: Value(time),
    );
  }

  factory CalendarTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalendarTableData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      time: serializer.fromJson<DateTime>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'time': serializer.toJson<DateTime>(time),
    };
  }

  CalendarTableData copyWith({
    int? id,
    String? date,
    String? title,
    String? description,
    DateTime? time,
  }) => CalendarTableData(
    id: id ?? this.id,
    date: date ?? this.date,
    title: title ?? this.title,
    description: description ?? this.description,
    time: time ?? this.time,
  );
  CalendarTableData copyWithCompanion(CalendarTableCompanion data) {
    return CalendarTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      time: data.time.present ? data.time.value : this.time,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalendarTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, title, description, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.title == this.title &&
          other.description == this.description &&
          other.time == this.time);
}

class CalendarTableCompanion extends UpdateCompanion<CalendarTableData> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> time;
  const CalendarTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.time = const Value.absent(),
  });
  CalendarTableCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String title,
    required String description,
    required DateTime time,
  }) : date = Value(date),
       title = Value(title),
       description = Value(description),
       time = Value(time);
  static Insertable<CalendarTableData> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? time,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (time != null) 'time': time,
    });
  }

  CalendarTableCompanion copyWith({
    Value<int>? id,
    Value<String>? date,
    Value<String>? title,
    Value<String>? description,
    Value<DateTime>? time,
  }) {
    return CalendarTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalendarTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

abstract class _$CalendarDatabase extends GeneratedDatabase {
  _$CalendarDatabase(QueryExecutor e) : super(e);
  $CalendarDatabaseManager get managers => $CalendarDatabaseManager(this);
  late final $CalendarTableTable calendarTable = $CalendarTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [calendarTable];
}

typedef $$CalendarTableTableCreateCompanionBuilder =
    CalendarTableCompanion Function({
      Value<int> id,
      required String date,
      required String title,
      required String description,
      required DateTime time,
    });
typedef $$CalendarTableTableUpdateCompanionBuilder =
    CalendarTableCompanion Function({
      Value<int> id,
      Value<String> date,
      Value<String> title,
      Value<String> description,
      Value<DateTime> time,
    });

class $$CalendarTableTableFilterComposer
    extends Composer<_$CalendarDatabase, $CalendarTableTable> {
  $$CalendarTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CalendarTableTableOrderingComposer
    extends Composer<_$CalendarDatabase, $CalendarTableTable> {
  $$CalendarTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalendarTableTableAnnotationComposer
    extends Composer<_$CalendarDatabase, $CalendarTableTable> {
  $$CalendarTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);
}

class $$CalendarTableTableTableManager
    extends
        RootTableManager<
          _$CalendarDatabase,
          $CalendarTableTable,
          CalendarTableData,
          $$CalendarTableTableFilterComposer,
          $$CalendarTableTableOrderingComposer,
          $$CalendarTableTableAnnotationComposer,
          $$CalendarTableTableCreateCompanionBuilder,
          $$CalendarTableTableUpdateCompanionBuilder,
          (
            CalendarTableData,
            BaseReferences<
              _$CalendarDatabase,
              $CalendarTableTable,
              CalendarTableData
            >,
          ),
          CalendarTableData,
          PrefetchHooks Function()
        > {
  $$CalendarTableTableTableManager(
    _$CalendarDatabase db,
    $CalendarTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CalendarTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$CalendarTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CalendarTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> time = const Value.absent(),
              }) => CalendarTableCompanion(
                id: id,
                date: date,
                title: title,
                description: description,
                time: time,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String date,
                required String title,
                required String description,
                required DateTime time,
              }) => CalendarTableCompanion.insert(
                id: id,
                date: date,
                title: title,
                description: description,
                time: time,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CalendarTableTableProcessedTableManager =
    ProcessedTableManager<
      _$CalendarDatabase,
      $CalendarTableTable,
      CalendarTableData,
      $$CalendarTableTableFilterComposer,
      $$CalendarTableTableOrderingComposer,
      $$CalendarTableTableAnnotationComposer,
      $$CalendarTableTableCreateCompanionBuilder,
      $$CalendarTableTableUpdateCompanionBuilder,
      (
        CalendarTableData,
        BaseReferences<
          _$CalendarDatabase,
          $CalendarTableTable,
          CalendarTableData
        >,
      ),
      CalendarTableData,
      PrefetchHooks Function()
    >;

class $CalendarDatabaseManager {
  final _$CalendarDatabase _db;
  $CalendarDatabaseManager(this._db);
  $$CalendarTableTableTableManager get calendarTable =>
      $$CalendarTableTableTableManager(_db, _db.calendarTable);
}
