import 'package:flutter/material.dart';
import 'package:notes_app_flutter/api/app-state.dart';
// import 'package:notes_app_flutter/pages/notelist.dart';
import 'package:notes_app_flutter/constants.dart';
import 'package:notes_app_flutter/pages/workspace.dart';
import 'package:notes_app_flutter/widgets/text-widgets.dart';
import 'package:notes_app_flutter/widgets/floating-search-bar.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        backgroundColor: kPurpleColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WorkSpace(),
            ),
          );
        },
      ),
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        // backgroundColor: Colors.grey[200],
        backgroundColor: kAppBarColor,
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(0.1),
              child: FloatingSearchBar(scaffoldKey: _scaffoldKey),
            ),
            const SizedBox(height: 25),
            const HeaderText(value: "Заметки"),
            Divider(
              color: Colors.grey[900],
              thickness: 2.0,
            ),
            const SizedBox(height: 15),
            Expanded(child: Provider.of<AppState>(context).notesModel.notesCount != 0 ? Consumer<AppState>(
              builder: (context, appState, child) {
                return ListView.builder(
                  itemCount: appState.notesModel.notesCount,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (builder) => WorkSpace(
                                noteIndex: index,
                              ))
                            );
                          },
                          title: Row(children: [
                            Icon(
                              Icons.school_rounded,
                              color: kLabelToColor[appState.notesModel.getNote(index).noteLabel],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            FieldText(value: 
                              appState.notesModel.getNote(index).noteTitle ?? "Note",
                            ),
                          ]),
                        ),
                      ),
                    );
                  },
                );
              }
              )
            : const Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "Вы еще не добавили ни одну заметку.\n\nПожалуйста, войдите снова, если вы уже регистрировались.",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}
