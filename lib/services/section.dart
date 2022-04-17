import 'package:flutter/material.dart';

class Section {
  late String name;
  late Color color;

  Section({required this.name, required this.color});
}

Future<List<Section>> getSections() {
  List<Section> sections = [
    Section(name: "Первый раздел", color: const Color.fromARGB(255, 61, 10, 162)),
    Section(name: "Second section", color: const Color.fromARGB(255, 167, 227, 48)),
    Section(name: "Третий модуль", color: const Color.fromARGB(255, 211, 137, 17)),
  ];
  return Future.delayed(const Duration(seconds: 1), () {
    return Future.value(sections);
  });
}
