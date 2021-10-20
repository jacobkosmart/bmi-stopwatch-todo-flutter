import 'package:bmi_stopwatch_todo/bmi/bmi_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BMI0 extends StatefulWidget {
  const BMI0({Key? key}) : super(key: key);

  @override
  _BMI0State createState() => _BMI0State();
}

class _BMI0State extends State<BMI0> {
  // 폼의 상태를 얻기 위한 키값
  final _formKey = GlobalKey<FormState>();

  // 키와 몸무게 값을 얻기 위한 TextEditingController
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  // 다사용한 컨트롤러의 인스턴스는 화면 종료될때 dispose() 메서드로 해제함
  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'BMI',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // 폼
          key: _formKey, // 키 할당
          child: SingleChildScrollView(
            // scroll 시 자동으로 키보드 감추기 기능
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: <Widget>[
                TextFormField(
                  // TextEditingController 인스턴스를 설정, 텍스트 필드를 조작할 때 사용함
                  controller: _heightController,
                  decoration: InputDecoration(
                    // 외곽선이 있고 힌트로 '키'를 표시
                    border: OutlineInputBorder(), // 외곽선
                    labelText: "당신의 키를 입력하세요",
                    hintText: 'cm',
                  ),
                  keyboardType: TextInputType.number, // 숫자만 입력
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      // 입력한 값의 앞뒤 공백을 제거한 것이 비었다면 에러 메시지 표시
                      return '키를 입력하세요';
                    }
                    return null; // null을 반환하면 에러가 없는 것임
                  },
                  // autofocus: true,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _weightController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "당신의 몸무게를 입력하세요",
                    hintText: 'kg',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return '키를 입력하세요';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // 폼에 입력된 값 검증 : 여기서 false 반환된다면 자동으로 TextFormField 아래에 오류메시지가 표시됨
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // BimResult 클래스의 생성자를 통새 키와 몸무게를 double 타입으로 전달됨
                            builder: (context) => BimResult(
                              // TextField 에 입력한 내용은 정수를 입력해도 문자열로 저장됨. 문자열을 doble 타입으로 전달 받으려면 double.parse() 함수를 사용해야함.
                              // text 프로퍼티로 TextFormField 에 입력된 값으로 부터 trim() 하면서 좌우 공백을 제거 해줌
                              double.parse(_heightController.text.trim()),
                              double.parse(_weightController.text.trim()),
                            ),
                          ),
                        );
                      }
                    },
                    child: Text('결과 보기'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
