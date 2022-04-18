import 'package:flutter/material.dart';
import 'package:notes_app_flutter/widgets/text-widgets.dart';

class WorkSpace extends StatefulWidget {
  const WorkSpace({Key? key}) : super(key: key);

  @override
  State<WorkSpace> createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpace> {
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
            const HeaderText(value: "Заметка"),
            Divider(
              color: Colors.grey[900],
              thickness: 2.0,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
