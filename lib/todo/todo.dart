import 'package:flutter/material.dart';

class Todo2 extends StatefulWidget {
  const Todo2({Key? key}) : super(key: key);

  @override
  _Todo2State createState() => _Todo2State();
}

class _Todo2State extends State<Todo2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Todo List',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
