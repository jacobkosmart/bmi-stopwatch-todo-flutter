# bmi_stopwatch_todoList

![Kapture 2021-10-21 at 14 51 28](https://user-images.githubusercontent.com/28912774/138219473-6724db55-1a0a-4031-a6e1-d91d950531ce.gif)

## 1.BMI

### 기능

- 키와 몸무게를 입력하고 결과 보기 버튼을 누르면 다른 화면에서 비만도 결과를 문자와 아이콘으로 보여 줍니다.

### Check Point!

- `Form.TextFormField.GlobalKey` 를 사용하면 입력 폼의 에러를 간단히 검증할 수 있습니다

- `TextFormField` 위젯은 `TextField` 위젯으 지능에 추가로 오류 검증 로직을 추가할 수 있는 위젯입니다.

- `TextFormField` 나 `TextField` 위젯에 입력된 값을 활용하려면 `TextEditingController` 클래스를 사용합니다.

## 2.Stop Watch

### 기능

- 타이머를 시작, 일시정지하고 초기화할 수 있습니다.

- 타이머 실행 중에 랩타임을 측정하여 표시합니다

### Check Point!

- `Timer` 클래스를 사용하여 정해진 시잔 간격으로 원하는 동작을 수행 시킬 수 있습니다.

- 숫자 형태의 문자열을 특정 자릿수로 만들고 0으로 채우려면 `padLeft()` 메서드를 사용합니다

- dart 에서 int 나누기 int 의 type 은 `double` 입니다

## 3.Toto List

### Firebase 연결 설정

- 작성한 '할 일 관리' 앱을 재시작하면 모든 자료가 사라지기 때문에 firebase 클라우드 DB 를 통해서 자료를 보과합니다

#### firebase core 패키지 설치

```yaml
# in pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^1.7.0
```

#### 안드로이드 접속 설정

1.firebase 에 접속하여 프로젝트를 생성하고, 파이어베이스 콘솔에서 안드로이드 앱 추가

- 안드로이드 앱의 패키지 명을 알아야 하는데 프로젝트 폴더 내 android/app 아래 `build.gradele` 파일 안에 `applicationID "com.example ...."` 의 ID 명복사 해놓고 앱등록 에서 Android 패키지 이름에 붙여 넣습니다.

- 앱 등록 하게 되면 `google-services.json` 파일을 다운로드 해서 android/app 폴더아래에 파일을 붙여 넣습니다. (`google-services.json` 파일은 개인 정보의 파이어 베이스 관련 정보가 담겨 있기 때문에 github 나, 공유 폴더 등 공유가 되지 않도록 유의 해야 합니다.)

  2.Firebase SDK 추가에서 dependencies { `classpath 'com.google.gms.google-services:...'` } 의 부분을 복사해서 프로젝트 내 `android/build.gradle` 의 안드로이드 환경 구성 파일 안에 해당내용을 붙여 넣기 합니다
  (주의!! flutter android 안에는 build.gradle 파일이 `2개` 있기 때문에 코드 입력 시 다른곳에에 입력 되지 않게 주의 해야 함 )

  3.계속해서 `apply plugin: 'com.google.gms.google-services'` 의 부분을 `build.gradle` 경로에 붙여 넣기 합니다.

  4.`main.dart` 파일안에 `runApp()` 실행전에 Firebase 를 초기화해서 Firestore 를 사용할 수 있도록 초기화 코드를 넣스니다.

```dart
// in main.dart
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(const MyApp());
}
```

#### iOS 접속 설정

> (iOS installation in flutter firebase)[https://firebase.flutter.dev/docs/installation/ios/]

1.firebase 에 접속하여 프로젝트를 생성하고, 파이어베이스 콘솔에서 iOS 앱 추가

- iOS 패키지 명을 알아야 하는데 프로젝트 내 ios/Runner.xcworkspace 파일을 xcode 로 열고 Runner 의 gerneral tab 에 Bundle Identifier 의 `com.example....` ID 명을 복사해서 앱 등록의 iOS 번들 ID 에 붙여 넣습니다. 하고 앱등록

- GoogleService-info.plist 파일을 다운로드 받아서 프로젝트 ios 안에 복사해 넣습니다

  2.firebase configuration file 설치

- 반드시 xcode 를 사용하여 프로젝트와 연결해야합니다. ( `GoogleService-info.plist` 파일을 연결 시켜줘야 합니다)

- `ios/Runner.xcworkspace` 파일을 xcode 로 열고, 오른쪽 버튼 클릭해서 `Add files to "Runner"` 선택한다음에 `GoogleService-Info.plist` 선택하고 반드시 Copy items if needed 를 체크 박스 를 선택해야 함

<img width="812" alt="스크린샷 2021-10-21 오전 10 26 36" src="https://user-images.githubusercontent.com/28912774/138195471-1f4b63bc-19f1-411e-872e-1567bb0e0049.png">

3.GoogleService-info.plist 파일의 'REVERSED_CLIENT_ID의 값을 복사한다. (xcode 상에서 )

- 최상위 Runner의 Target 'Runner'에서 최하단의 Url type을 새로 추가한다.

- 금방 복사한 내용을 'Url Schemes'에 입력한다.

![image](https://user-images.githubusercontent.com/28912774/138198099-510595e1-c1ef-4c39-a02d-7dedf5fdc9b9.png)

4.프로젝트에 ios 에 pod 파일이 없을 경우 `pod init` 해주고, 있거나생성하면 `Podfile` 에 들어가서 다음 코드를 복사 해줍니다

```bash
# add pods for desired Firebase products
# https://firebase.google.com/docs/ios/setup#available-pods
```

- 그리고 나서 `pod install` 해주면 firebase core 가 자동으로 설치됩니다 그리고 프로젝트 실행해줘서 firebase 가 초기화되어 앱 실행이 잘되는지 확인해 줍니다

#### Web 접속 설정

> (Firebase Web in flutter)[https://firebase.flutter.dev/docs/installation/web/]

- Add firebase SKDs 는 web/index.html 에서 CDN import 해서 만이 동작 됩니다,

```html
<html>
  ...
  <body>
    <!-- Add this line -->
    <script src="https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js"></script>

    <!-- ------ -->
    <script src="main.dart.js" type="application/javascript"></script>
  </body>
</html>
```

- Firebase 를 초기화 하기 (firebase 에서 web app 을 생성하고 CDN 의 다음과 같이 firebaseConfig 부분을 같이 사용 한것임)

```html
<!-- Firebase Configuration -->
<script>
  var firebaseConfig = {
    apiKey: "...",
    authDomain: "[YOUR_PROJECT].firebaseapp.com",
    databaseURL: "https://[YOUR_PROJECT].firebaseio.com",
    projectId: "[YOUR_PROJECT]",
    storageBucket: "[YOUR_PROJECT].appspot.com",
    messagingSenderId: "...",
    appId: "1:...:web:...",
    measurementId: "G-...",
  };

  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
</script>
```

### FireStore 연결

> [Firebase Docs](https://firebase.google.com/docs/firestore)

#### firebase store 패키지 설치

```yaml
# in pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^1.7.0
  cloud_firestore: ^2.5.3
```

#### collection 생성

![image](https://user-images.githubusercontent.com/28912774/138208829-ecc91543-838a-4916-bc00-4f7bf14586cd.png)

#### 할일 목록 가져오기 (Query)

- 위에 스크린샷의 목록을 가져오기

  1.Todo 클래스 수정

```dart
class Todo {
  bool isDone;
  late String title;

  // constructor
  // isDone 프로퍼티를 optional property 로 고치고 기본갓을 false 로 지정합니다
  Todo(this.title, {this.isDone = false});
}

```

2.ListTile 형태로 변경하는 메서드 변경

```dart
Widget _buildItemWidget(DocumentSnapshot doc) {
  // Firestore 문서의 DocumentSnapshot 클래스의 인스턴스 받아서 Todo 객체를 생성하는 코드 추가
  final todo = Todo(doc['title'], isDone: doc['isDone']);
```

3.StreamBuilder 작성

```dart
// Expanded 글자위에 StreamBuilder warp widget 합니다
// todo 컬렉션의 데이터가 지속적으로 나오게 스트림을 통해 UI 를 그립니다. 여기서 StreamBuilder 를 사용해서 연결해 두면 스트림 값이 변할 때마다 builder 부분이 다시 호출됩니다. 이때 매번 전체 화면을 다시 그리지 않고 StreamBuilder 로 일부분만 그리는데 Firestore에서 snapshots() 메서드를 사용해서 데이터 스트림을 얻습니다.

StreamBuilder<QuerySnapshot>(
  // stream : todo collection 에 있는 모든 문서를 스트림으로 얻음. 자료가 변경 될때 화면에 다시 그려 주기 위해 StreamBuilder 클래스와 함께 사용합니다
  stream: FirebaseFirestore.instance.collection('todo').snapshots(),
  // builder : BuldContext 와 QuerySnapshot 객체가 각각 context 와 snapshot 으로 넘어옴
  builder: (context, snapshot) {
    // snapshot.hasData 로 자료 유무를 얻음 여기서 자료가 없을 때 로딩 표시를 하도록 합니다
    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }
    // snapshot 의 모든 문서를 document 로 변수 지정
    final documents = snapshot.data!.docs;
    return Expanded(
      child: ListView(
        // _items 리스트의 항목을 map() 내부순환해서  통해 내부 순환해 todo 인수로 _buildItemWidget() 을 메서드로 반환하고 이를 toList() 해서 다시 리스트로 반환 합니다
        // documents 를 map 반복하고 리스트로 반환해서 화면에 그림
        children:
            documents.map((doc) => _buildItemWidget(doc)).toList(),
      ),
    );
  },
),
```

4.메서드 개수 제한 피하기

- Firestore 라이브러리의 메서드가 65,536 개가 넘기 때문에 안드로이드 버전을 최소 21 이상으로 설정해주면 됩니다

```bash
#  in android/app/build.gradle
minSdkVersion 21
```

#### 할일 추가하기 (insert)

```dart
void _addTodo(Todo todo) {
  // Firebase 의 Firestore 의 instance 의 collection 'todo' 를 불러와서 .add() 메서드는 Map 형식으로 데이터를 저장합니다.
  FirebaseFirestore.instance
      .collection('todo')
      .add({'title': todo.title, 'isDone': todo.isDone});
  _todoController.text = ''; // 할일 입력 필드 비움
}
```

#### 할일 완료/미완료 토글 (Update)

```dart
  // 할일 완료/미완료 메서드
  // 특정 문서를 업데이트 하려면 문서 ID 가 필요하는데 DocumentSnapshot 을 통해 문서 ID 를 얻을 수 있으며 doc() 메서드에 인수로 전달하고 update() 메서드에 수정하고자 하는 내용을 Map 형태로 전달하면 자료가 업데이트 됨
  void _toggleTodo(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('todo').doc(doc.id).update({
      'isDone': !doc['isDone'],
    });
  }
```

#### 할일 삭제 (Delete)

## reference

Flutter cookbook - [https://flutter.dev/docs/cookbook](https://flutter.dev/docs/cookbook)

오준석의 생존코딩 - [https://book.jacobko.info/#/book/1162244372](https://book.jacobko.info/#/book/1162244372)

플러터로 세계정복 - [https://muhly.tistory.com/24](https://muhly.tistory.com/24)
