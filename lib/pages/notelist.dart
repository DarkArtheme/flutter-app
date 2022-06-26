// yet unused
import 'package:flutter/material.dart';
import 'package:notes_app_flutter/pages/workspace.dart';
import 'package:notes_app_flutter/widgets/text-widgets.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List<String> sections = ["Первый", "Второй", "Третий", "Четвертый"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const HeaderText(value: "Страницы"),
            Divider(
              color: Colors.grey[900],
              thickness: 2.0,
            ),
            const SizedBox(height: 15),
            ListView.builder(
              itemCount: sections.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => WorkSpace())
                        );
                      },
                      title: FieldText(value: sections[index]),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
