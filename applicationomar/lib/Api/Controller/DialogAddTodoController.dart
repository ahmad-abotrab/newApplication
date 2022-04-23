import 'package:get/state_manager.dart';

class DialogAddtTodoController extends GetxController {
  int index;
  @override
  void onInit() {
    index = 0;
    super.onInit();
  }

  updateIndex(value) {
    this.index = value;
    update();
  }
}
