import 'package:flutter/material.dart';
import 'package:notes_app_flutter/api/app-state.dart';
import 'package:notes_app_flutter/constants.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NoteWritingSection extends StatefulWidget {
  String? startingTitle;
  String startingContent;
  Function editNoteTitleCallback;
  Function editNoteContentCallback;

  NoteWritingSection(
      {Key? key, this.startingTitle,
      required this.startingContent,
      required this.editNoteTitleCallback,
      required this.editNoteContentCallback}) : super(key: key);

  @override
  _NoteWritingSectionState createState() => _NoteWritingSectionState();
}

class _NoteWritingSectionState extends State<NoteWritingSection> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.startingTitle ?? "";
    _contentController.text = widget
        .startingContent; // Any note object here will always have some content.
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
              color: kDarkThemeBackgroundColor,
              width: 0.2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kDarkThemeBackgroundColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kDarkThemeBackgroundColor,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: kDarkThemeBackgroundColor,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                hintText: "Title",
                hintStyle: TextStyle(fontSize: 24),
              ),
              style: const TextStyle(fontSize: 24),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                widget.editNoteTitleCallback(value);
              },
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note",
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  widget.editNoteContentCallback(value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
