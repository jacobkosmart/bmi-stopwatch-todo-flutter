import 'package:flutter/material.dart';
// Timer 클래스를 사용하기 위한 async 패키지 import
import 'dart:async';

class StopWatch1 extends StatefulWidget {
  const StopWatch1({Key? key}) : super(key: key);

  @override
  _StopWatch1State createState() => _StopWatch1State();
}

class _StopWatch1State extends State<StopWatch1> {
  // 타이머 : 일정 간격 동안 반복하여 동작을 수행하야 할 때 사용하는 클래스
  late Timer _timer;

  var _time = 0; // 0.01초 마다 1씩 증가실킬 변수
  var _isRunning = false; // 현지 시작 상태를 나타낼 boolean 변수

  final List<String> _lapTimes = []; // 랩타임에 표시할 시간을 저장할 리스트

  @override
  // Timer 클래스가 앱을 종료 할 때 반복되는 동작을 취소해야함. is
  void dispose() {
    // _timer 르 ㄹ한번도 동작시키지 않았을 때도 (null 인 상태)에도 안전하게 동작을 취소 하려면 ?. 연산자 사용
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Stop Watch',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _bodyBuilder(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[100],
        child: Container(
          height: 50,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // 시작 버튼 클릭하면 _clickButton 버튼 시작
        onPressed: () {
          setState(() {
            _clickButton();
          });
        },
        child: _isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyBuilder() {
    // sec :  몫을 구하는 연산자 ~/ 을 사용하여 1/100 초 단위로 sec 에 저장함
    var sec = _time ~/ 100; // 초
    // hundredth 는 100으로 나눈 나머지가 1/100 초 단위 (hundredth) 가 되고 이 영역은 00 ~ 99 까지 표시하기 위해 왼쪽의 빈곳을 0으로 채우기 위해 padLeft() 를 사용해서 2자리로 표현하고 빈자리는 '0' 문자로 채워 줍니다
    var hundredth = '${_time % 100}'.padLeft(2, '0'); // 1/100초

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        // Stack 위젯 내부에는 여러 위젯을 겹쳐서 사용할 수 있습니다. Positioned 위젯을 Stack 위젯의 children 프로퍼티에서 자유롭게 위치, 크기 조정 할 수 있습니다 (left, rught, top, bottom, width, height)
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  // 시간을 표시하는 영역
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "$sec",
                      style: TextStyle(fontSize: 60),
                    ),
                    Text(hundredth), // 1 /100초
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  // 랩타입을 표시하는 영역
                  width: 100,
                  height: 300,
                  child: ListView(
                    // list 의 각각의 값들이 Text() 위젯으로 나타 나겠금 만들고, 다시 list 형태로 return
                    children: _lapTimes.map((time) => Text(time)).toList(),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 40,
              bottom: 10,
              child: FloatingActionButton(
                // 왼쪽 아래에 위치한 초기화 버튼
                backgroundColor: Colors.deepOrange,
                onPressed: _reset,
                child: Icon(Icons.rotate_left),
              ),
            ),
            Positioned(
              // 오른쪽 아래에 위치한 랩타임 버튼
              right: 40,
              bottom: 10,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _recordLapTime('$sec.$hundredth');
                  });
                },
                child: Icon(Icons.timer),
              ),
            ),
          ],
        ),
      ),
    );
  }

// 시작 또는 일시 정지 버튼 클릭

  void _clickButton() {
    _isRunning = !_isRunning;
    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

// 백분의 1초에 한 번씩 time 변수를 1 증가
  void _start() {
    // Timer.periodic() 메서드의 첫번째 인수 Duration 인스턴스레 설정 하면 두번째 인수 받는 함수에서 실행되는 구조 : milliseconds : 천 분의 1초 단위 임
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  // 타이머 취소
  void _pause() {
    _timer.cancel();
  }

  // 초기화 하고 화면을 다시 그립니다
  void _reset() {
    setState(() {
      _isRunning = false;
      _timer.cancel();
      _lapTimes.clear();
      _time = 0;
    });
  }

  // 랩타임 기록
  // _lapTimes 리스트 의 크기만큼 index 다음에 다음 기록이 누적되겠금 1등 부터 의 시간을 표시 합니다
  void _recordLapTime(String time) {
    _lapTimes.insert(_lapTimes.length, '${_lapTimes.length + 1}등 $time');
  }
}
