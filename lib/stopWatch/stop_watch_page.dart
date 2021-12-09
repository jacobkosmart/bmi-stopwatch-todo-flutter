import 'package:bmi_stopwatch_todo/stopWatch/stop_watch_controller.dart';
import 'package:flutter/material.dart';
// Timer 클래스를 사용하기 위한 async 패키지 import

import 'package:get/get.dart';

class StopWatchPage extends GetView<StopWatchController> {
  const StopWatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Stop Watch',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
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
            controller.clickButton();
          },
          child: controller.isRunning.value
              ? Icon(Icons.pause)
              : Icon(Icons.play_arrow),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _bodyBuilder() {
    // sec :  몫을 구하는 연산자 ~/ 을 사용하여 1/100 초 단위로 sec 에 저장함

    RxInt _sec = (controller.time.value ~/ 100).obs;

    // hundredth 는 100으로 나눈 나머지가 1/100 초 단위 (hundredth) 가 되고 이 영역은 00 ~ 99 까지 표시하기 위해 왼쪽의 빈곳을 0으로 채우기 위해 padLeft() 를 사용해서 2자리로 표현하고 빈자리는 '0' 문자로 채워 줍니다
    RxString _hundredth =
        ('${controller.time % 100}'.padLeft(2, '0')).obs; // 1/100초

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        // Stack 위젯 내부에는 여러 위젯을 겹쳐서 사용할 수 있습니다. Positioned 위젯을 Stack 위젯의 children 프로퍼티에서 자유롭게 위치, 크기 조정 할 수 있습니다 (left, rught, top, bottom, width, height)
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Obx(
                  () => Row(
                    // 시간을 표시하는 영역
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "$_sec",
                        style: TextStyle(fontSize: 60),
                      ),
                      Text("$_hundredth 초"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  // 랩타입을 표시하는 영역
                  width: 100,
                  height: 300,
                  child: ListView(
                    // list 의 각각의 값들이 Text() 위젯으로 나타 나겠금 만들고, 다시 list 형태로 return
                    children:
                        controller.lapTimes.map((time) => Text(time)).toList(),
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
                onPressed: controller.reset,
                child: Icon(Icons.rotate_left),
              ),
            ),
            Positioned(
              // 오른쪽 아래에 위치한 랩타임 버튼
              right: 40,
              bottom: 10,
              child: FloatingActionButton(
                onPressed: () {
                  controller.recordLapTime("$_sec.$_hundredth");
                },
                child: Icon(Icons.timer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
