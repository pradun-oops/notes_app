import 'package:flutter/material.dart';
import 'package:notes/helper/db_helper.dart';
import 'package:notes/models/model.dart';

class DbProvider extends ChangeNotifier {
  DbHelper dbHelper;
  DbProvider({required this.dbHelper});

  List<NoteModel> _mNotes = [];

  List<NoteModel> getAllNotes() => _mNotes;

  void addNote(NoteModel newNote) async {
    bool check = await dbHelper.addNote(newNote: newNote);
    if (check) {
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }
  }

  void getInitialNotes() async {
    _mNotes = await dbHelper.fetchAllNotes();
    notifyListeners();
  }

  void deleteNote(int id) async {
    bool check = await dbHelper.deleteNote(id);
    if (check) {
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }
  }

  void updateNote(NoteModel updateNote) async {
    bool check = await dbHelper.updateNote(updateNote);
    if (check) {
      _mNotes = await dbHelper.fetchAllNotes();
      notifyListeners();
    }
  }
}
