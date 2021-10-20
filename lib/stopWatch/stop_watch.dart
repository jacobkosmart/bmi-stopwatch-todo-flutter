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
      body: _buildBody(),
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
        child: Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// Body 내용 부분
Widget _buildBody() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 30),
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
                    "0",
                    style: TextStyle(fontSize: 60),
                  ),
                  Text('00'), // 1 /100초
                ],
              ),
              Container(
                // 랩타입을 표시하는 영역
                width: 100,
                height: 100,
                child: ListView(
                  children: <Widget>[],
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
              onPressed: () {},
              child: Icon(Icons.rotate_left),
            ),
          ),
          Positioned(
            // 오른쪽 아래에 위치한
            right: 40,
            bottom: 10,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.timer),
            ),
          )
        ],
      ),
    ),
  );
}

// 시작 또는 일시 정지 버튼 클릭

void _clickButton() {}
