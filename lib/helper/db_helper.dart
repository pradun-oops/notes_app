// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:notes/models/model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static DbHelper getInstance() => DbHelper._();
  static const String TABLE_NOTE = "notes";
  static const String COLUMN_NOTE_ID = "id";
  static const String COLUMN_NOTE_TITLE = "title";
  static const String COLUMN_NOTE_DESCRIPTION = "description";
  static const String COLUMN_NOTE_CREATED_AT = "created_at";

  Database? _db;
  Future<Database> getDb() async {
    _db ??= await openDb();
    return _db!;
  }

  Future<Database> openDb() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDocDir.path, 'notesDB.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $TABLE_NOTE (
            $COLUMN_NOTE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_NOTE_TITLE TEXT,
            $COLUMN_NOTE_DESCRIPTION TEXT,
            $COLUMN_NOTE_CREATED_AT TEXT
          )
        ''');
      },
    );
  }

  Future<bool> addNote({required NoteModel newNote}) async {
    Database db = await getDb();

    int rowEffect = await db.insert(TABLE_NOTE, newNote.toMap());
    return rowEffect > 0;
  }

  Future<List<NoteModel>> fetchAllNotes() async {
    var db = await getDb();

    List<Map<String, dynamic>> mnotes = await db.query(TABLE_NOTE);

    List<NoteModel> allNotes = [];

    for (Map<String, dynamic> eachNote in mnotes) {
      allNotes.add(NoteModel.fromMap(eachNote));
    }

    return allNotes;
  }

  Future<bool> updateNote(NoteModel updatedNote) async {
    var db = await getDb();
    int rowsEffected = await db.update(TABLE_NOTE, updatedNote.toMap(),
        where: "$COLUMN_NOTE_ID = ?", whereArgs: ["${updatedNote.nId}"]);

    return rowsEffected > 0;
  }

  Future<bool> deleteNote(int id) async {
    var db = await getDb();

    int rowsEffected =
        await db.delete(TABLE_NOTE, where: "$COLUMN_NOTE_ID = $id");

    return rowsEffected > 0;
  }
}
