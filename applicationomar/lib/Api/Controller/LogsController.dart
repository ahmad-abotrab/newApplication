import 'package:applicationomar/Api/fetchData.dart';
import 'package:applicationomar/models/Operations/Sell.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LogsController extends GetxController {
  static int currentStep = 0;
  var valueStepper;
  String typeOfStepper = 'year';
  PageController pageController = new PageController(initialPage: 1);
  List<String> titleStep;
  List<Sell> sellsInThisDay = [];

  @override
  void onInit() {
    titleStep = [];
    currentStep = 0;
    DateTime date = DateTime.now();
    String dayDateNow = DateFormat('EEEE').format(date);
    sellsInThisDay = FetchData().sells.where((element) {
      String dateTemp = DateFormat('EEEE').format(element.date);

      return dateTemp == dayDateNow;
    }).toList();
    super.onInit();
  }

  updateTitleStep(value) {
    this.titleStep = value;
    update();
  }

  updatePageView(value) {
    this.pageController.nextPage(
        duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
    print(currentStep);
    print(titleStep[currentStep]);

    sellsInThisDay = FetchData().sells.where((element) {
      String dateTemp = DateFormat('EEEE').format(element.date);

      return dateTemp == titleStep[currentStep];
    }).toList();
    update();
  }

  updateType(value) {
    this.typeOfStepper = value;
    update();
  }

  updateValueStep(value) {
    currentStep = value;
    update();
  }
}
