// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static DbHelper getInstance() => DbHelper._();
  static const String TABLE_NOTE = "notes";
  static const String COLUMN_NOTE_ID = "id";
  static const String COULMN_NOTE_TITLE = "title";
  static const String COULMN_NOTE_DESCRIPTION = "description";
  static const String COULMN_NOTE_CREATED_AT = "created_at";

  Database? _db;
  Future<Database> getDb() async {
    _db ??= await openDb();
    return _db!;
  }

  Future<Database> openDb() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDocDir.path, 'notes.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) {
        db.execute('''
    CREATE TABLE $TABLE_NOTE(
      $COLUMN_NOTE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $COULMN_NOTE_TITLE TEXT,
      $COULMN_NOTE_DESCRIPTION TEXT,
      $COULMN_NOTE_CREATED_AT TEXT,
    )
''');
      },
    );
  }

  Future<bool> addNote(
      {required String title, required String description}) async {
    Database database = await getDb();

    int rowEffect = await database.insert(TABLE_NOTE, {
      COULMN_NOTE_TITLE: title,
      COULMN_NOTE_DESCRIPTION: description,
      COULMN_NOTE_CREATED_AT: DateTime.now().microsecondsSinceEpoch.toString(),
    });
    return rowEffect > 0;
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    var database = await getDb();

    List<Map<String, dynamic>> notes = await database.query(TABLE_NOTE);
    return notes;
  }
}
