import 'package:flutter/material.dart';
import 'package:notes_app_flutter/api/app-state.dart';
import 'package:notes_app_flutter/models/note.dart';
import 'package:notes_app_flutter/widgets/text-widgets.dart';
import 'package:notes_app_flutter/constants.dart';
import 'package:notes_app_flutter/widgets/label-selector-dialog.dart';
import 'package:provider/provider.dart';

class WorkSpace extends StatefulWidget {
  final int? noteIndex;

  const WorkSpace({Key? key, this.noteIndex}) : super(key: key);

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
          title: const Text('Notes'),
          centerTitle: true,
          backgroundColor: Colors.purple[300],
        ),
        body: Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const HeaderText(value: "Заметка"),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_sharp, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_note.noteContent != "") {
                            appState.saveNote(_note, widget.noteIndex);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter some content for the note."),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.visibility, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[900],
                thickness: 2.0,
              ),
              const SizedBox(height: 15),
              const TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                style: TextStyle(
                  fontFamily: 'AnonymousPro',
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your text here...',
                ),
              ),
              BottomNoteOptions(
                note: _note, 
                deviceHeight: deviceHeight, 
                deviceWidth: deviceWidth, 
                deleteNoteCallback: () {
                  if (widget.noteIndex != null)
                    appState.deleteNote(_note);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNoteOptions extends StatefulWidget {
  /// This will be a reference to the note object in NoteScreen.
  /// This allows access to label and content. Content for sharing.
  NoteModel note;
  final Function? deleteNoteCallback;
  final double deviceHeight;
  final double deviceWidth;

  BottomNoteOptions(
      {required this.note,
      required this.deviceHeight,
      required this.deviceWidth,
      required this.deleteNoteCallback});

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
    return Container(
      height: widget.deviceHeight * 0.09,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              Icons.star,
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
            icon: Icon(Icons.delete_outline),
            iconSize: 28,
            onPressed: () {
              this.widget.deleteNoteCallback?.call();
            },
          ),
          IconButton(
            icon: Icon(Icons.share_outlined),
            iconSize: 28,
            onPressed: () {
              // if (widget.note.noteContent.isEmpty)
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text("There is no content in the note to share."),
              //     ),
              //   );
              // else
              //   Share.share(widget.note.noteContent);
              // // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
