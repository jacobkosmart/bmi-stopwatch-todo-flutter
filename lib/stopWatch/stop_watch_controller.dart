// Timer 클래스를 사용하기 위한 async 패키지 import
import 'dart:async';
import 'package:get/get.dart';

class StopWatchController extends GetxController {
  static StopWatchController get to => Get.find();

  // 타이머 : 일정 간격 동안 반복하여 동작을 수행하야 할 때 사용하는 클래스
  late Timer timer;
  // 0.01초 마다 1씩 증가실킬 변수
  RxInt time = 0.obs;
  // 현지 시작 상태를 나타낼 boolean 변수
  RxBool isRunning = false.obs;

  // 랩타임에 표시할 시간을 저장할 리스트
  List<String> lapTimes = [];

  // 시작 또는 일시정비 버튼 클릭
  void clickButton() {
    isRunning.value = !isRunning.value;
    if (isRunning.value) {
      start();
    } else {
      pause();
    }
    update();
  }

  // 백분의 1초에 한 번씩 time 변수를 1 증가
  // Timer.periodic() 메서드의 첫번째 인수 Duration 인스턴스레 설정 하면 두번째 인수 받는 함수에서 실행되는 구조 : milliseconds : 천 분의 1초 단위 임
  void start() {
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      time.value++;
    });
  }

  // 타이머 취소
  void pause() {
    timer.cancel();
  }

  // 초기화 하고 화면을 다시 그립니다
  void reset() {
    isRunning.value = false;
    timer.cancel();
    lapTimes.clear();
    time = 0.obs;
    update();
  }

  // 랩타임 기록
  // lapTimes 리스트의 크기만큼 index 다음에 다음 기록이 누적되겠금 1등 부터 의 시간을 표시 합니다
  void recordLapTime(String time) {
    lapTimes.insert(lapTimes.length, "${lapTimes.length + 1}등 $time ");
  }
}
