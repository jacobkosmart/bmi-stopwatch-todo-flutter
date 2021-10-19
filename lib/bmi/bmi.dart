import 'package:flutter/material.dart';

class BMI0 extends StatefulWidget {
  const BMI0({Key? key}) : super(key: key);

  @override
  _BMI0State createState() => _BMI0State();
}

class _BMI0State extends State<BMI0> {
  // 폼의 상태를 얻기 위한 키값
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'BMI',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // 폼
          key: _formKey, // 키 할당
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  // 외곽선이 있고 힌트로 '키'를 표시
                  border: OutlineInputBorder(), // 외곽선
                  hintText: '키',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
