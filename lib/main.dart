import 'package:bmi_stopwatch_todo/dashboard/dashboard.dart';
import 'package:bmi_stopwatch_todo/dashboard/dashboard_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BST(BMI/Watch/Todo)',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: "/",
      initialBinding: DashboardBinding(),
      getPages: [
        GetPage(
          name: "/",
          page: () => MyDashBoard(),
        )
      ],
    );
  }
}



// Previous Code (before updating GetX bottom Nav)
/* class Home extends StatefulWidget {
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
    // 키보드 밖으로 클릭 시, 키보드 감추기 (! 해당 경로 최상단 Scaffold 를 warp 하고 GestureDetector 설정)
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
      ),
    );
  }
}
*/