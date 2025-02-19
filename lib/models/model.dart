import 'package:notes/helper/db_helper.dart';

class NoteModel {
  int? nId;
  String nTitle;
  String nDescription;
  String nCreatedAt;
  NoteModel({
    this.nId,
    required this.nTitle,
    required this.nDescription,
    required this.nCreatedAt,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
        nId: map[DbHelper.COLUMN_NOTE_ID],
        nTitle: map[DbHelper.COLUMN_NOTE_TITLE],
        nDescription: map[DbHelper.COLUMN_NOTE_DESCRIPTION],
        nCreatedAt: map[DbHelper.COLUMN_NOTE_CREATED_AT]);
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.COLUMN_NOTE_TITLE: nTitle,
      DbHelper.COLUMN_NOTE_DESCRIPTION: nDescription,
      DbHelper.COLUMN_NOTE_CREATED_AT: nCreatedAt,
    };
  }
}
