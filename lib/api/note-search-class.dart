import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app_flutter/api/app-state.dart';
import 'package:notes_app_flutter/constants.dart';
import 'package:notes_app_flutter/pages/workspace.dart';
import 'package:provider/provider.dart';
import 'package:notes_app_flutter/widgets/text-widgets.dart';

class NoteSearchClass extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // This will show a clear query button
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // A back button to close the search.
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // These are the suggestions when the user presses enter.
    return showSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // These are suggestions that will appear when user hasn't typed anything.
    return showSearchResults(context);
  }

  Widget showSearchResults(BuildContext context) {
    /// Tap into all the notes and find out note indexes that contain the
    /// user's search query. After that, create a Staggered Grid View just like
    /// the HomeScreen with the results. The functionality is pretty much the
    /// same as the rest. Just an extra step to populate the Staggered Grid View.

    List<int> relevantIndexes = Provider.of<AppState>(context).notesModel.searchNotes(query);

    if (relevantIndexes.isEmpty) {
      return const Center(
        child: Text(
          "Не найдены элементы, удовлетворяющие условиям поиска",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Consumer<AppState>(
      builder: (context, appState, child) {
        return ListView.builder(
          itemCount: relevantIndexes.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => WorkSpace(
                              noteIndex: relevantIndexes[index],
                            )));
                  },
                  title: Row(children: [
                    Icon(
                      Icons.school_rounded,
                      color: kLabelToColor[appState.notesModel.getNote(relevantIndexes[index]).noteLabel],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FieldText(
                      value: appState.notesModel.getNote(relevantIndexes[index]).noteTitle ?? "Note",
                    ),
                  ]),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
