import 'package:bmi_stopwatch_todo/bmi/bmi.dart';
import 'package:bmi_stopwatch_todo/dashboard/dashboard_controller.dart';
import 'package:bmi_stopwatch_todo/model/custom_animated_bottom.dart';
import 'package:bmi_stopwatch_todo/stopWatch/stop_watch_page.dart';
import 'package:bmi_stopwatch_todo/todo/todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDashBoard extends GetView<DashboardController> {
  const MyDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 뒤로가기 버튼을 누르게 되면 onwillpop 에 event 가 잡히게 되는것
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: GetBuilder<DashboardController>(
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: controller.tabIndex,
                children: [
                  Todo2(),
                  // NestingRouting 을 위해서 GetX 가 아닌 Navigatior 로 넘김
                  Navigator(
                    key: controller.navigatorKey,
                    onGenerateRoute: (routeSettings) {
                      return MaterialPageRoute(
                        builder: (context) => BMIPage(),
                      );
                    },
                  ),
                  StopWatchPage(),
                  /* Navigator(
                    key: controller.navigatorKey,
                    onGenerateRoute: (routeSettings) {
                      return MaterialPageRoute(
                        builder: (context) => InternalStorage(),
                      );
                    },
                  ), */
                ],
              ),
            ),
            bottomNavigationBar: CustomAnimatedBottomBar(
              containerHeight: 70,
              backgroundColor: Colors.white,
              selectedIndex: controller.tabIndex,
              showElevation: true,
              itemCornerRadius: 24,
              curve: Curves.easeIn,
              onItemSelected: controller.changeTabIndex,
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: Icon(Icons.check_box),
                  title: Text('Todo-List'),
                  activeColor: Colors.green,
                  inactiveColor: controller.inActiveColor,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.no_meals),
                  title: Text('BMI'),
                  activeColor: Colors.purpleAccent,
                  inactiveColor: controller.inActiveColor,
                  textAlign: TextAlign.center,
                ),
                // BottomNavyBarItem(
                //   icon: Icon(Icons.sd_storage),
                //   title: Text(
                //     'External',
                //   ),
                //   activeColor: Colors.pink,
                //   inactiveColor: controller.inActiveColor,
                //   textAlign: TextAlign.center,
                // ),
                BottomNavyBarItem(
                  icon: Icon(Icons.watch),
                  title: Text('StopWatch'),
                  activeColor: Colors.blue,
                  inactiveColor: controller.inActiveColor,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
