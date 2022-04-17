import 'package:flutter/material.dart';

class NoteText extends StatelessWidget {
  final String value;
  const NoteText({Key? key, required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'AnonymousPro',
        fontSize: 14,
        color: Colors.black,
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  final String value;
  const HeaderText({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.w500,
        fontSize: 24,
        color: Colors.grey[900],
      )
    );
  }
}

class FieldText extends StatelessWidget {
  final String value;
  const FieldText({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.w300,
        fontSize: 16,
        color: Colors.grey[900],
      )
    );
  }
}
