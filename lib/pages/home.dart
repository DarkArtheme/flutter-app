import 'package:flutter/material.dart';
import 'package:notes_app_flutter/pages/notelist.dart';
import 'package:notes_app_flutter/widgets/text-widgets.dart';
import 'package:notes_app_flutter/services/section.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Section> sections = [];

  void load(Function notifyParent) async {
    sections = await getSections();
    notifyParent(sections);
  }

  @override
  void initState() {
    super.initState();
    load((List<Section> sect) {
      setState(() {
        sections = sect;
      });
    });
  }

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
            const HeaderText(value: "Разделы"),
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
                          context, MaterialPageRoute(builder: (context) => const NoteList())
                        );
                      },
                      title: Row(children: [
                        Icon(
                          Icons.school_rounded,
                          color: sections[index].color,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FieldText(value: sections[index].name),
                      ]),
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
