# bmi_stopwatch_todo

## 1.BMI

### 기능

- 키와 몸무게를 입력하고 결과 보기 버튼을 누르면 다른 화면에서 비만도 결과를 문자와 아이콘으로 보여 줍니다.

### check point!

- `Form.TextFormField.GlobalKey` 를 사용하면 입력 폼의 에러를 간단히 검증할 수 있습니다

- `TextFormField` 위젯은 `TextField` 위젯으 지능에 추가로 오류 검증 로직을 추가할 수 있는 위젯입니다.

- `TextFormField` 나 `TextField` 위젯에 입력된 값을 활용하려면 `TextEditingController` 클래스를 사용합니다.

### 주요 코드

#### 1. 클릭시 키보드 감추기

- 키보드 밖으로 클릭 시, 키보드 감추기 (! 해당 경로 최상단 Scaffold 를 warp 하고 GestureDetector 설정)

```dart
return GestureDetector(
  onTap: () {
    FocusScope.of(context).unfocus();
  },
  child: Scaffold( ....
```

## reference

Flutter cookbook - [https://flutter.dev/docs/cookbook](https://flutter.dev/docs/cookbook)

오준석의 생존코딩 - [https://book.jacobko.info/#/book/1162244372](https://book.jacobko.info/#/book/1162244372)
