import 'package:flutter/widgets.dart';
import 'package:my_portfolio/models/notes_model.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabaseService {
  static final NotesDatabaseService instance =
      NotesDatabaseService._constructor();

  static Database? _notesDb;
  NotesDatabaseService._constructor();

  static const String dbName = 'notes.db';
  static const int dbVersion = 1;
  final String tableName = 'Notes';

  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnContent = 'content';
  final String columnDate = 'date';

  Future<Database> get database async {
    if (_notesDb != null) return _notesDb!;
    return await _initializeDb();
  }

  Future<Database> _initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = databasePath + dbName;

    return await openDatabase(path, version: dbVersion, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    await db.execute('''CREATE TABLE $tableName(
      $columnId INTEGER PRIMARY KEY,
      $columnTitle TEXT NOT NULL,
      $columnContent TEXT NOT NULL,
      $columnDate TEXT NOT NULL
    )''');
  }

  Future<int> addNotes(String title, String content) async {
    Database db = await instance.database;
    return db.insert(tableName, {
      columnTitle: title,
      columnContent: content,
      columnDate: DateTime.now().toUtc().toString(),
    });
  }

  Future<List<NotesModel>> getNotes() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> notes = await db.query(tableName);
    debugPrint(notes.toString());
    return notes.map((note) => NotesModel.fromJson(note)).toList();
  }

  Future<int> updateNote(NotesModel note) async {
    Database db = await instance.database;
    return db.update(
      tableName,
      note.toJson(),
      where: '$columnId = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNotes(List<int> ids) async {
    Database db = await instance.database;
    int deletedCount = 0;

    for (int id in ids) {
      deletedCount += await db.delete(
        tableName,
        where: '$columnId = ?',
        whereArgs: [id],
      );
    }

    return deletedCount;
  }

  Future closeDb() async {
    Database db = await instance.database;
    db.close();
  }
}
