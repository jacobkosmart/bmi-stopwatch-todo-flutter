import 'package:flutter/material.dart';

class BimResult extends StatefulWidget {
  final double height;
  final double weight;

  //  BMI constructor
  BimResult(this.height, this.weight);

  @override
  State<BimResult> createState() => _BimResultState();
}

class _BimResultState extends State<BimResult> {
  @override
  Widget build(BuildContext context) {
    // weight 를 height 의 제곱으로 나누면 BMI 갑이 됨. 키 단위가 m (미터) 이기 때문에 100 으로 각가 나눔
    final bmi = widget.weight / ((widget.height / 100) * (widget.height / 100));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'BMI 결과',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          tooltip: '뒤로 가기',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              // TODO : 수정할 부분 (글자)
              _calcBmi(bmi),
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(height: 16),
            _buildIcon(bmi),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('뒤로 가기'),
            ),
          ],
        ),
      ),
    );
  }
}

// BMI 값에 따른 text (String) 값
String _calcBmi(double bmi) {
  var result = '저체중';
  if (bmi >= 35) {
    result = '고도 비만';
  } else if (bmi >= 30) {
    result = '2단계 비만';
  } else if (bmi >= 25) {
    result = '1단계 비만';
  } else if (bmi >= 23) {
    result = '과체중';
  } else if (bmi >= 18.5) {
    result = '정상';
  }
  return result;
}

// BMI 값에 대한 Icon 변경
Widget _buildIcon(double bmi) {
  if (bmi >= 23) {
    return Icon(
      Icons.sentiment_very_dissatisfied,
      color: Colors.red,
      size: 100,
    );
  } else if (bmi >= 18.5) {
    return Icon(
      Icons.sentiment_satisfied,
      color: Colors.green,
      size: 100,
    );
  } else {
    return Icon(
      Icons.sentiment_dissatisfied,
      color: Colors.orange,
      size: 100,
    );
  }
}
