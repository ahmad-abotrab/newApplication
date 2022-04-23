import 'package:get/get_state_manager/get_state_manager.dart';

class LoginController extends GetxController {
  bool visable;
  @override
  void onInit() {
    visable = false;
    super.onInit();
  }

  updateVisiable(value) {
    this.visable = value;
    update();
  }



}
