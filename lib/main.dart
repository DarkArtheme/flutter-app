// import 'dart:js';
import 'package:flutter/material.dart';
import 'package:notes_app_flutter/pages/home.dart';
import 'package:notes_app_flutter/pages/loading.dart';
import 'package:notes_app_flutter/pages/notelist.dart';
import 'package:notes_app_flutter/pages/workspace.dart';
import 'package:notes_app_flutter/api/app-state.dart';
import 'package:provider/provider.dart';

late AppState appState;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  appState = AppState();
  appState.initialization().then((_) => appState.readNotes());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => appState,
      child: Builder(
        builder: (BuildContext context) => MaterialApp(home: Home()),
      ),
    );
  }
}
