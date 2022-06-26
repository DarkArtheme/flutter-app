import 'package:flutter/cupertino.dart';
import 'package:notes_app_flutter/constants.dart';
import 'package:notes_app_flutter/api/db-manager.dart';
import 'package:notes_app_flutter/models/note.dart';
import 'package:notes_app_flutter/models/notes.dart';

class AppState extends ChangeNotifier {
  String userEmail = kDefaultEmail;
  // late CollectionReference notesCollection;
  // This flag depends upon whether online sync is enabled or not. If not enabled,
  // data is only written to the offline storage. If enables, then data is
  // written only to firestore. (Firestore has local persistence too).
  bool useSql = true;
  DbManager _dbManager = DbManager.instance;

  NotesModel notesModel = NotesModel();

  Future<void> initialization() async {
    // await Firebase.initializeApp();
  }

  void readNotes() {
    if (useSql) {
      _dbManager.initDatabase().then((value) {
        readNotesFromSqlite();
      });
    }
  }

  void readNotesFromSqlite() async {
    notesModel = await _dbManager.getAllNotes();
    notifyListeners();
  }

  void saveNote(NoteModel newNote, [int? index]) {
    this.notesModel.saveNote(newNote, index);

    if (index == null) {
      // Creating a note
      if (useSql) {
        _dbManager.insert(newNote);
      } 
    } else {
      if (useSql) {
        _dbManager.update(newNote);
      } 
    }
    notifyListeners();
  }

  void deleteNote(NoteModel note) {
    this.notesModel.deleteNote(note: note);

    if (useSql) {
      _dbManager.delete(note);
    }
    notifyListeners();
  }
}
