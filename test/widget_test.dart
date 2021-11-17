// http 서버와 통신을 할때 필요한 라이브러리
import 'dart:io';

void main() {
  showData();
}

void showData() {
  startTask();
  accessData();
  fetchData();
}

void startTask() {
  String info1 = "요청수행 시작";
  print(info1);
}

void accessData() {
  Duration time = Duration(seconds: 1);

  if (time.inSeconds > 2) {
    // sleep(time);
    Future.delayed(time, () {
      String info2 = "데이터 처리 완료";
      print(info2);
    });
  } else {
    String info2 = "데이터를 가져 왔습니다";
    print(info2);
  }
}

void fetchData() {
  String info3 = "잔액은 8,500만원 입니다";
  print(info3);
}
