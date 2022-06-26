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
    notesModel.saveNote(newNote, index);

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
    notesModel.deleteNote(note: note);

    if (useSql) {
      _dbManager.delete(note);
    }
    notifyListeners();
  }

  Future<kLoginCodesEnum> loginUser({String? email, String? password}) async {
    // try {
    //   await FirebaseAuth.instance
    //       .createUserWithEmailAndPassword(email: email!, password: password!);

    //   // After user is created, the local database needs to be migrated to
    //   // Firestore and local files need to be cleaned.
    //   userEmail = email;
    //   useSql = false;

    //   migrateLocalDataToFirestore();
    //   notesModel =
    //       NotesModel(); // Creating new notes model as it will have fresh data from firestore.

    //   readNotes();
    //   return kLoginCodesEnum.successful;
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     return kLoginCodesEnum.weak_password;
    //   } else if (e.code == 'email-already-in-use') {
    //     // Account exists. Just login
    //     try {
    //       await FirebaseAuth.instance
    //           .signInWithEmailAndPassword(email: email!, password: password!);

    //       userEmail = email;
    //       useSql = false;

    //       migrateLocalDataToFirestore();
    //       notesModel =
    //           NotesModel(); // Creating new notes model as it will have fresh data from firestore.
    //       readNotes();
    //       return kLoginCodesEnum.successful;
    //     } on FirebaseAuthException catch (e) {
    //       if (e.code == 'wrong-password') {
    //         return kLoginCodesEnum.wrong_password;
    //       } else {
    //         print("Some issue while logging in");
    //         return kLoginCodesEnum.unknownError;
    //       }
    //     }
    //   } else {
    //     print("Some issue while registration");
    //     return kLoginCodesEnum.unknownError;
    //   }
    // }
    return kLoginCodesEnum.successful;
  }

  void migrateLocalDataToFirestore() {
    // // Since there is copy of all notes in the memory (notesModel property),
    // // just copy them to Firestore and delete the database.
    // notesCollection = FirebaseFirestore.instance.collection(userEmail);
    // for (int i = 0; i < notesModel.notesCount; i++) {
    //   notesCollection
    //       .doc(notesModel.getNote(i).id)
    //       .set({
    //         'title': notesModel.getNote(i).noteTitle,
    //         'content': notesModel.getNote(i).noteContent,
    //         'label': notesModel.getNote(i).noteLabel
    //       })
    //       .then((value) => print("Note added in firestore"))
    //       .catchError(
    //           (error) => print("There was an error while adding note: $error"));
    // }
    // _databaseHelper.deleteNotesDatabase();
    
  }
}


