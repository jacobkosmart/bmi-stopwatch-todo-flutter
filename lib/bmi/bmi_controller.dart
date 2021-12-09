import 'package:bmi_stopwatch_todo/model/bmi_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BMIController extends GetxController {
  static BMIController get to => Get.find();

  BMI? bmi;

  BMIController({this.bmi});

  // 키의 상태를 얻기 위한 키값 생성
  var formKey = GlobalKey<FormState>();

  // TextEditingController 인스턴스를 설정, 텍스트 필드를 조작할 때 사용함
  var heightController = TextEditingController();
  var weightController = TextEditingController();
}
