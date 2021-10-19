import 'package:flutter/material.dart';
import 'bmi/bmi.dart';
import 'stopWatch/stop_watch.dart';
import 'todo/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _index = 0;
  final _pages = [
    BMI0(),
    StopWatch1(),
    Todo2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     'BMI / StopWatch / Todo',
      //     style: TextStyle(color: Colors.black),
      //   ),
      // ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.no_meals),
            label: 'BMI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch),
            label: 'Stop Watch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Todo List',
          ),
        ],
      ),
    );
  }
}