import 'package:bmi_stopwatch_todo/bmi/bmi_controller.dart';
import 'package:bmi_stopwatch_todo/dashboard/dashboard_controller.dart';
import 'package:bmi_stopwatch_todo/stopWatch/stop_watch_controller.dart';
import 'package:get/instance_manager.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<BMIController>(() => BMIController());
    Get.lazyPut<StopWatchController>(() => StopWatchController());
  }
}
