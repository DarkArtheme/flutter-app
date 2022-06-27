import 'package:flutter/material.dart';
import 'package:notes_app_flutter/api/app-state.dart';
import 'package:notes_app_flutter/models/note.dart';
import 'package:notes_app_flutter/widgets/note-writing-section.dart';
import 'package:notes_app_flutter/constants.dart';
import 'package:notes_app_flutter/widgets/label-selector-dialog.dart';
import 'package:provider/provider.dart';


class WorkSpace extends StatefulWidget {
  final int? noteIndex;

  // ignore: prefer_const_constructors_in_immutables
  WorkSpace({Key? key, this.noteIndex}) : super(key: key);

  @override
  State<WorkSpace> createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpace> {
  late NoteModel _note;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.noteIndex != null) {
      _note = NoteModel(
        noteTitle: Provider.of<AppState>(context).notesModel.getNote(widget.noteIndex!).noteTitle,
        noteContent:
            Provider.of<AppState>(context).notesModel.getNote(widget.noteIndex!).noteContent,
        noteLabel: Provider.of<AppState>(context).notesModel.getNote(widget.noteIndex!).noteLabel,
        id: Provider.of<AppState>(context).notesModel.getNote(widget.noteIndex!).id,
      );
    } else {
      _note = NoteModel(noteContent: "");
    }
  }

  void editNoteTitle(String newTitle) {
    /// This is a callback that allows the NoteWritingScreen to edit the note
    /// object in this class.
    _note.noteTitle = newTitle;
  }

  void editNoteContent(String newContent) {
    /// This is a callback that allows the NoteWritingScreen to edit the note
    /// object in this class.
    _note.noteContent = newContent;
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Consumer<AppState>(
      builder: (context, appState, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          leading: const BackButton(color: kLightThemeBackgroundColor),
          elevation: 4,
          title: const Text(
            "Редактирование",
            style: TextStyle(color: kLightThemeBackgroundColor),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.check, color: kLightThemeBackgroundColor),
              onPressed: () {
                // Every new note must have some content.
                if (_note.noteTitle != null && _note.noteTitle != "") {
                  appState.saveNote(_note, widget.noteIndex);
                  print("save: title=${_note.noteTitle} content=${_note.noteContent} label=${_note.noteLabel}");
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Пожалуйста, заполните поле с названием!"),
                    ),
                  );
                }
              },
            )
          ],
        ),
        body: Hero(
          tag: widget.noteIndex != null ? 'note_box_${widget.noteIndex}' : 'note_box',
          child: SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: deviceHeight - (MediaQuery.of(context).padding.top + kToolbarHeight),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceHeight * 0.01, vertical: deviceWidth * 0.015),
                          child: NoteWritingSection(
                            startingTitle: _note.noteTitle,
                            startingContent: _note.noteContent,
                            editNoteTitleCallback: editNoteTitle,
                            editNoteContentCallback: editNoteContent,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      BottomNoteOptions(
                        deviceHeight: deviceHeight,
                        deviceWidth: deviceWidth,
                        note: _note,
                        deleteNoteCallback: () {
                          if (widget.noteIndex != null) {
                            appState.deleteNote(_note);
                          }
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BottomNoteOptions extends StatefulWidget {
  /// This will be a reference to the note object in NoteScreen.
  /// This allows access to label and content. Content for sharing.
  NoteModel note;
  final Function? deleteNoteCallback;
  final double deviceHeight;
  final double deviceWidth;

  BottomNoteOptions(
      {Key? key,
      required this.note,
      required this.deviceHeight,
      required this.deviceWidth,
      required this.deleteNoteCallback})
      : super(key: key);

  @override
  _BottomNoteOptionsState createState() => _BottomNoteOptionsState();
}

class _BottomNoteOptionsState extends State<BottomNoteOptions> {
  void changeLabelCallback(int newLabelIndex) {
    /// Callback for the AlertDialog to change label in the
    /// BottomNoteOptions class instance.
    setState(() {
      /// Since this a reference to note object in NoteScreen,
      /// changes will reflect there too.
      widget.note.noteLabel = newLabelIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.deviceHeight * 0.09,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              Icons.school_rounded,
              color: kLabelToColor[widget.note.noteLabel],
            ),
            iconSize: 28,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return LabelSelectorDialog(
                      selectedLabel: widget.note.noteLabel,
                      deviceWidth: widget.deviceWidth,
                      changeLabelCallback: changeLabelCallback,
                    );
                  });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            iconSize: 28,
            onPressed: () {
              widget.deleteNoteCallback?.call();
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            iconSize: 28,
            onPressed: () {
              // if (widget.note.noteContent.isEmpty)
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text("There is no content in the note to share."),
              //     ),
              //   );
              // else {
              //   Share.share(widget.note.noteContent);
              // }
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
