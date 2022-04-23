import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController {
  bool isDarkTheme;
  Locale locale;
  String longuageCode;
  @override
  void onInit() {
    this.isDarkTheme = true;
    this.locale = new Locale('ar');
    this.longuageCode = 'ar';
    super.onInit();
  }

  updateThemeApp() {
    this.isDarkTheme = !this.isDarkTheme;
    update();
  }

  updateLangCode(value) {
    this.longuageCode = value;
    update();
  }

  updateLocale(value) {
    this.locale = value;
    print(this.locale.languageCode.toString());
    update();
  }
}
