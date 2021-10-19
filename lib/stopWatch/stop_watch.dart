import 'package:flutter/material.dart';

class StopWatch1 extends StatefulWidget {
  const StopWatch1({Key? key}) : super(key: key);

  @override
  _StopWatch1State createState() => _StopWatch1State();
}

class _StopWatch1State extends State<StopWatch1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Stop Watch',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(),
        ),
      ),
    );
  }
}
