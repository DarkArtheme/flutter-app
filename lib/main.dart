import 'package:flutter/material.dart';
import 'package:notes_app_flutter/pages/home.dart';
import 'package:notes_app_flutter/pages/loading.dart';
import 'package:notes_app_flutter/pages/notelist.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': ((context) => const Loading()),
    '/home': ((context) => const Home()),
    '/notelist': ((context) => const NoteList()),
  },
));
