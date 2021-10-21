import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo2 extends StatefulWidget {
  const Todo2({Key? key}) : super(key: key);

  @override
  _TodoState2 createState() => _TodoState2();
}

class _TodoState2 extends State<Todo2> {
  // todo 문자열 저장할 리스트
  final _items = <Todo>[];

  // todo 조작을 위한 컨트롤러 생성
  final _todoController = TextEditingController();

  @override

  // 컨트롤러는 사용이 끝나면 dispose() 호출해서 메서드로 해제해야 함
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Todo List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                // TodoList 작성 textField
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      labelText: '당신의 할일을 적으세요!',
                    ),
                    keyboardType: TextInputType.text,
                    onSubmitted: (String title) {
                      _addTodo(Todo(title));
                    },
                    autofocus: true,
                  ),
                ),
                SizedBox(width: 10),
                // add 버튼
                ElevatedButton(
                  onPressed: () {
                    _addTodo(
                      Todo(_todoController.text),
                    );
                  },
                  child: Text('ADD'),
                )
              ],
            ),
            // Expanded 글자위에 stremBuilder warp widget 합니다
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
          ],
        ),
      ),
    );
  }

  // 할일 객체를 ListTile 형태로 변경하는 메서드
  Widget _buildItemWidget(DocumentSnapshot doc) {
    // Firestore 문서의 DocumentSnapshot 클래스의 인스턴스 받아서 Todo 객체를 생성하는 코드 추가
    final todo = Todo(doc['title'], isDone: doc['isDone']);

    return ListTile(
      onTap: () {
        // 메서드를 todo 에서 doc으로 수정
        _toggleTodo(doc);
      }, // 클릭시 완료 / 취소 될수 있도록 수정
      title: Text(
        todo.title, // 할일
        style: todo.isDone
            ? TextStyle(
                // 완료 되었을때 스타일은 취소선과 이탤릭체
                decoration: TextDecoration.lineThrough,
                fontStyle: FontStyle.italic,
              )
            : null, // 완료 스타일 변경 없음
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          // todo 에서 doc 으로 변경
          _deleteTodo(doc);
        },
      ),
    );
  }

  // 할일 추가 메서드
  void _addTodo(Todo todo) {
    // Firebase 의 Firestore 의 instance 의 collection 'todo' 를 불러와서 .add() 메서드는 Map 형식으로 데이터를 저장합니다.
    FirebaseFirestore.instance
        .collection('todo')
        .add({'title': todo.title, 'isDone': todo.isDone});
    _todoController.text = ''; // 할일 입력 필드 비움
  }

  // 할일 삭제 메서드
  // 삭제 시에도 문서 ID 가 필요하기에 Todo 가 아닌 DocumentSnapshot 을 인수로 받고 delete() 로 데이터 삭제함
  void _deleteTodo(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('todo').doc(doc.id).delete();
  }

  // 할일 완료/미완료 메서드
  // 특정 문서를 업데이트 하려면 문서 ID 가 필요하는데 DocumentSnapshot 을 통해 문서 ID 를 얻을 수 있으며 doc() 메서드에 인수로 전달하고 update() 메서드에 수정하고자 하는 내용을 Map 형태로 전달하면 자료가 업데이트 됨
  void _toggleTodo(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('todo').doc(doc.id).update({
      'isDone': !doc['isDone'],
    });
  }
}

class Todo {
  bool isDone;
  late String title;

  // constructor
  // isDone 프로퍼티를 optional property 로 고치고 기본갓을 false 로 지정합니다
  Todo(this.title, {this.isDone = false});
}
