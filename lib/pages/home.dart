import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Test'),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      ),
      body: const Center(
        child: TextExample(value: "Hello, world!!!!!"),
        // child: Image.asset('images/example-image.jpg'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text('Click'),
        onPressed: () => {},
      ),
    );
  }
}

class TextExample extends StatelessWidget {
  final String value;
  const TextExample({Key? key, required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'AnonymousPro',
        fontSize: 30,
        color: Colors.black,
      ),
    );
  }
}
